class VotesApiController < ApplicationController
  before_action :authenticate

def index_user_votedcontributionsAPI
  @usuari = User.find(params[:id])
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @contributions = []
  if @user[0].id != @usuari.id
    render :json => {"Error": "Unauthorized user"}.to_json, status: 401
  else
    @vote = Vote.where(:idUsuari => @user[0].id)
    if @vote[0].nil?
      render :json => {:error => "This user does not have voted comments"}.to_json, status: 404
    else
        @vote.each do |vote|
          if @contribution = Contribution.find_by(:id => vote.idContrib)
          @contributions.push(@contribution)
          end
        end
        render json: @contributions
    end
  end
end

def createContributionVoteAPI
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    @vote = Vote.where(:idUsuari => @user[0].id, :idContrib => params[:id])
    if not @vote[0].nil?
      render :json => {:error => "The vote already exists"}.to_json, status: 403
    else
      @contribution_vote = Vote.new(:idContrib => params[:id])
      @contribution_vote.idUsuari = @user[0].id 
      @contribution = Contribution.where(:id => @contribution_vote.idContrib)
      if @contribution[0].nil?
        render :json => {:error => "The contribution does not exists"}.to_json, status: 404
      else
        @contribution[0].points +=1
        @contribution[0].save
        if @contribution_vote.save
         render @contribution_vote
        end
      end
    end
end

def destroyContributionVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @contribution_vote = Vote.where(:idContrib => params[:id], :idUsuari => @user[0].id)
  if @contribution_vote[0].nil?
    render :json => {:error => "The vote does not exist"}.to_json, status: 404
  else
    @contribution = Contribution.find(@contribution_vote[0].idContrib)
    if @contribution.author == @user[0].username
      render :json => {:error => "You cannot delete the vote because you are the author of the contribution"}.to_json, status: 403
    else
      @contribution_vote[0].destroy
      @contribution.points -= 1
      @contribution.save
      render :json => {:message => "removed" }.to_json, status: 204
    end
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vote_params
    params.require(:votes_api).permit(:idContrib, :idUsuari)
  end
end