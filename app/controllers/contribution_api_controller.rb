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
