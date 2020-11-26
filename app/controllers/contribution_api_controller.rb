class ContributionApiController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy, :points]
  
  # GET /contributions
  # GET /api/contributions.json
  def indexAPI
    @contributions = Contribution.where.not(url: "").order(points: :desc)
    render json: @contributions
  end
  
  
  def indexNewAPI
    @contributions = Contribution.all.order("created_at DESC")
    render json: @contributions
  end
  
  
  def indexAskAPI
    @contributions = Contribution.where(url: "").order("created_at DESC")
    render json: @contributions
  end
  
  def show
    @comment = Comment.new
    @comments = Comment.where(contributions_id: @contribution.id).order("created_at DESC")
  end
  
end
