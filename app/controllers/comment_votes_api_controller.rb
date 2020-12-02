class CommentVotesApiController < ApplicationController
  before_action :authenticate
  
def createCommentVoteAPI
    @comment_vote = CommentVote.new(:idComment => params[:id])
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    @comment_vote.idUsuari = @user[0].id 
    @comment = Comment.find(@comment_vote.idComment)
    @comment.points +=1
    @comment.save
    if @comment_vote.save
     render @comment_vote  
    end
end

def destroyCommentVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @comment_vote = CommentVote.where(:idComment => params[:id], :idUsuari => @user[0].id)
  if @comment_vote[0].nil?
    render :json => {:error => "The vote does not exist"}.to_json, status: 404
  else
    @comment = Comment.find(@comment_vote[0].idComment)
    @comment_vote[0].destroy
    @comment.points -= 1
    @comment.save
    render :json => {:message => "removed" }.to_json, status: 204
  end
end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_vote
      @comment_vote = CommentVote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_vote_params
      params.require(:comment_votes_api).permit(:idComment, :idUsuari)
    end
end