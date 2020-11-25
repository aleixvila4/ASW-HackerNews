class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy, :points]
  
  # GET /contributions
  # GET /contributions.json
  def index
    @contributions = Contribution.where.not(url: "").order(points: :desc)
  end

  def indexNew
    @contributions = Contribution.all.order("created_at DESC")
    render json: @contributions
  end
  
  
  def indexAsk
    @contributions = Contribution.where(url: "").order("created_at DESC")
    render json: @contributions
  end
  
  def index_user_contributions
    @user = User.find(params[:user])
    @contributions = Contribution.where(author: @user.username).order("created_at DESC")
  end
  
  def index_voted_user_contributions
    @contributions = Contribution.all.order("created_at DESC")
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
    @comment = Comment.new
    @comments = Comment.where(contributions_id: @contribution.id).order("created_at DESC")
  end
  
  def showUrlExistente 
  end

  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end
  
  
  # GET /contributions/1/edit
  def edit
   
  end

  # POST /contributions
  # POST /contributions.json
  def create
    require 'uri'
    @contribution = Contribution.new(contribution_params)
    @contribution.author = current_user.username
    if not @contribution.title.empty? and (not @contribution.url.empty? or not @contribution.text.empty?)
      if Contribution.exists?(url: @contribution.url) and not @contribution.url.empty?
          @contribution = Contribution.find_by(url: @contribution.url)
          redirect_to @contribution, notice: 'The URL you wanted to add already exists.'
      end
      if @contribution.url =~ URI::regexp
        logger.debug @contribution.url
         if !defined?(@points) 
              @points = 0 
         end
          respond_to do |format|
            if @contribution.save
              @vote = Vote.new(:idUsuari => current_user.id, :idContrib => @contribution.id)
              @vote.save
              @contribution.points += 1
              @contribution.save
              if not @contribution.url.empty?
              format.html { redirect_to contributions_url}
              else
              format.html { redirect_to contributions_AskIndex_path}
              end
            else
              format.html { render :new }
              format.json { render json: @contribution.errors, status: :unprocessable_entity }
            end
          end
      else 
        redirect_to request.referrer, notice: "The URL is not valid."
      end
    else 
      redirect_to request.referrer, notice: 'All the fields are empty.'
    end
  
    
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to @contribution, notice: 'Contribution was successfully updated.' }
        format.json { render :edit, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
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
    respond_to do |format|
      format.html { redirect_to root_path,notice: 'Contribution was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
      
    end

    # Only allow a list of trusted parameters through.
    def contribution_params
      params.require(:contribution).permit(:title, :author, :url, :text)
    end
end
