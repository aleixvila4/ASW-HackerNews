class RepliesApiController < ApplicationController
before_action :set_reply, only: [:updateReplyAPI, :destroyReplyAPI]

def show_replyAPI
  @reply = Reply.where(id: params[:id])
  if @reply[0] == nil
    render :json => {"Error": "Reply not found"}.to_json, status: 404
  else
    render json: @reply
  end
end

def createReplyAPI
  @reply = Reply.new(reply_params)
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @reply.users_id = @user[0].id
  @reply.comments_id = params[:id]
  if @reply.replyText.empty?
    render :json => {:error => "The text is empty"}.to_json, status: 400
  else
    @reply.save
    @vote = ReplyVote.new(:idUsuari => @user[0].id, :idReply => @reply.id)
    @vote.save
    @reply.points += 1
    @reply.save
    render json: @reply
  end
end

def updateReplyAPI
  @R = Reply.new(reply_params)
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  if @R.replyText.empty?
    render :json => {:error => "The text is empty"}.to_json, status: 400
  elsif @reply.users_id != @user[0].id
    render :json => {:error => "Unauthorized user"}.to_json, status: 401
  elsif @reply.update(reply_params)
    render json: @reply
  end
end

def destroyReplyAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  if @user[0].id != @reply.users_id
    render :json => {:error => "Unauthorized user"}.to_json, status: 401
  else
    while not ReplyVote.find_by(idReply: @reply.id).nil? do
      ReplyVote.find_by(idReply: @reply.id).destroy
    end
    @reply.destroy
    render :json => {:message => "removed" }.to_json, status: 204
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_params
      params.require(:replies_api).permit(:replyText, :comments_id, :users_id)
    end

end
