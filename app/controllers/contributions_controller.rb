class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy, :points]
  #:link -->no hace nada, lo puse para hacer una cosa de link pero no me ha salido
  
  # GET /contributions
  # GET /contributions.json
  def index
    @contributions = Contribution.where.not(url: "").order(points: :desc)
  end

  def indexNew
    @contributions = Contribution.all.order("created_at DESC")
  end
  
  def indexAsk
    @contributions = Contribution.where(url: "").order("created_at DESC")
  end
  
  def indexComments
    @contributions = Contribution.all.order("created_at DESC")
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
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
  
  def points 
    @contribution.points += 1
    @contribution.save
    redirect_to Rails.application.routes.recognize_path(request.referrer)
  end
  

  # POST /contributions
  # POST /contributions.json
  def create
    
    @contribution = Contribution.new(contribution_params)
    if Contribution.exists?(url: @contribution.url) and not @contribution.url.empty?
        @contribution = Contribution.find_by(url: @contribution.url)
        render :show, notice: 'url existent'
    else
     if !defined?(@points) 
          @points = 0 end
      respond_to do |format|
        if @contribution.save
          format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }

        else
          format.html { render :new }
          format.json { render json: @contribution.errors, status: :unprocessable_entity }
        end
      end
    end
  
    
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { render :edit, notice: 'Contribution was successfully updated.' }
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
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }
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
        
        #@author = "autor"
    end
end
