class ReplyVotesApiController < ApplicationController
  before_action :authenticate

def createReplyVoteAPI
  @reply_vote = ReplyVote.new(:idReply => params[:id])
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @reply_vote.idUsuari = @user[0].id 
  @reply = Reply.find(@reply_vote.idReply)
  @reply.points +=1
  @reply.save
  if @reply_vote.save
   render @reply_vote
  end
end

def destroyReplyVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @reply_vote = ReplyVote.where(:idReply => params[:id], :idUsuari => @user[0].id)
  if @reply_vote[0].nil?
    render :json => {:error => "The vote does not exist"}.to_json, status: 404
  else
    @reply = Reply.find(@reply_vote[0].idReply)
    @reply_vote[0].destroy
    @reply.points -= 1
    @reply.save
    render :json => {:message => "removed" }.to_json, status: 204
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