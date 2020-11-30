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
  
  def show
    @comment = Comment.new
    @comments = Comment.where(contributions_id: @contribution.id).order("created_at DESC")
  end
  
end
