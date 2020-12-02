class VotesApiController < ApplicationController
  before_action :authenticate

def createContributionVoteAPI
    @contribution_vote = Vote.new(:idContrib => params[:id])
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    @contribution_vote.idUsuari = @user[0].id 
    @contribution = Contribution.find(@contribution_vote.idContrib)
    @contribution.points +=1
    @contribution.save
    if @contribution_vote.save
     render @contribution_vote
    end
end

def destroyContributionVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @contribution_vote = Vote.where(:idContrib => params[:id], :idUsuari => @user[0].id)
  if @contribution_vote[0].nil?
    render :json => {:error => "The vote does not exist"}.to_json, status: 404
  else
    @contribution = Contribution.find(@contribution_vote[0].idContrib)
    @contribution_vote[0].destroy
    @contribution.points -= 1
    @contribution.save
    render :json => {:message => "removed" }.to_json, status: 204
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