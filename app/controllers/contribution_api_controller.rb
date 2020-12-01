class ContributionApiController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy, :points]
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
