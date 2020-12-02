class ReplyVotesApiController < ApplicationController
  before_action :authenticate

def createReplyVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @vote = ReplyVote.where(:idUsuari => @user[0].id, :idReply => params[:id])
  if not @vote[0].nil?
    render :json => {:error => "The vote already exists"}.to_json, status: 403
  else
    @reply_vote = ReplyVote.new(:idReply => params[:id])
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    @reply_vote.idUsuari = @user[0].id 
    @reply = Reply.where(:id => @reply_vote.idReply)
    if @reply[0].nil?
      render :json => {:error => "The reply does not exists"}.to_json, status: 404
    else
      @reply[0].points +=1
      @reply[0].save
      if @reply_vote.save
       render @reply_vote
      end
    end
  end
end

def destroyReplyVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @reply_vote = ReplyVote.where(:idReply => params[:id], :idUsuari => @user[0].id)
  if @reply_vote[0].nil?
    render :json => {:error => "The vote does not exist"}.to_json, status: 404
  else
    @reply = Reply.find(@reply_vote[0].idReply)
    if @reply.users_id == @user[0].id
      render :json => {:error => "You cannot delete the vote because you are the author of the reply"}.to_json, status: 403
    else
      @reply_vote[0].destroy
      @reply.points -= 1
      @reply.save
      render :json => {:message => "removed" }.to_json, status: 204
    end
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply_vote
      @reply_vote = ReplyVote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_vote_params
      params.require(:reply_votes_api).permit(:idReply, :idUsuari)
    end
end