class ContributionApiController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :updateAPI, :destroyAPI, :points]
  before_action :authenticate
  
  # GET /contributions
  # GET /api/contributions.json
  def indexAPI
    if @flag == 0
      @contributions = Contribution.where.not(url: "").order(points: :desc)
      render json: @contributions
    end
  end
  
  
  def indexNewAPI
    if @flag == 0
     @contributions = Contribution.all.order("created_at DESC")
     render json: @contributions
    end
  end
  
  
  def indexAskAPI
    if @flag == 0
      @contributions = Contribution.where(url: "").order("created_at DESC")
      render json: @contributions
    end
  end
  
  def index_comments_contributions
    if @flag == 0
      @comments = Comment.where(contributions_id: params[:id]).order("created_at DESC")
      if @comments[0] == nil
        render :json => {"Error": "Comment not found"}.to_json, status: 404
      else
        render json: @comments
      end
    end
  end
  
  def createContributionAPI
    require 'uri'
    @contribution = Contribution.new(contribution_params)
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    @contribution.author = @user[0].username
    if @contribution.title.empty?
      render :json => {:error => "The title is empty"}.to_json, status: 400
    elsif @contribution.url.empty? and @contribution.text.empty?
      render :json => {:error => "The fields are empty"}.to_json, status: 400
    elsif not @contribution.url.empty?
        if Contribution.exists?(url: @contribution.url)
          render :json => {:error => "The URL already exists"}.to_json, status: 403
        elsif @contribution.url =~ URI::regexp
            if !defined?(@points) 
                @points = 0 
            end
        else
          render :json => {:error => "The URL is not valid"}.to_json, status: 400
        end
    else
      @contribution.save
      @vote = Vote.new(:idUsuari => @user[0].id, :idContrib => @contribution.id)
      @vote.save
      @contribution.points += 1
      @contribution.save
      render json: @contribution
    end
  end
  
  def updateAPI
    @C = Contribution.new(contribution_params)
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    if @C.title.empty?
      render :json => {:error => "The title is empty"}.to_json, status: 400
    elsif @contribution.url.empty? and @C.text.empty?
      render :json => {:error => "The text is empty"}.to_json, status: 400
    elsif @contribution.author != @user[0].username
      render :json => {:error => "Unauthorized user"}.to_json, status: 401
    elsif @contribution.update(contribution_params)
    render json: @contribution
    end
  end

  def destroyAPI
    while not Comment.find_by(contributions_id: @contribution.id).nil? do
      while not Reply.find_by(comments_id: Comment.find_by(contributions_id: @contribution.id).id).nil? do
      Reply.find_by(comments_id: Comment.find_by(contributions_id: @contribution.id).id).destroy
      end
      Comment.find_by(contributions_id: @contribution.id).destroy
    end
    while not Vote.find_by(idContrib: @contribution.id).nil? do
      Vote.find_by(idContrib: @contribution.id).destroy
    end
    @contribution.destroy
    render :json => {:message => "removed" }.to_json, status: 204
  end
  
private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
      
    end

    # Only allow a list of trusted parameters through.
    def contribution_params
      params.require(:contribution_api).permit(:title, :author, :url, :text)
    end
end
