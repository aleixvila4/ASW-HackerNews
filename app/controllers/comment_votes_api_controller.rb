class CommentVotesApiController < ApplicationController
  before_action :authenticate
  
def index_user_votedcommentsAPI
  @usuari = User.find(params[:id])
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @comments = []
  if @user[0].id != @usuari.id
    render :json => {"Error": "Unauthorized user"}.to_json, status: 401
  else
    @comment_vote = CommentVote.where(:idUsuari => @user[0].id)
    if @comment_vote[0].nil?
      render :json => {:error => "This user does not have voted comments"}.to_json, status: 404
    else
        @comment_vote.each do |vote|
          if @comment = Comment.find_by(:id => vote.idComment)
          @comments.push(@comment)
          end
        end
        render json: @comments
    end
  end
end

def createCommentVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @vote = CommentVote.where(:idUsuari => @user[0].id, :idComment => params[:id])
  if not @vote[0].nil?
    render :json => {:error => "The vote already exists"}.to_json, status: 403
  else
    @comment_vote = CommentVote.new(:idComment => params[:id])
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    @comment_vote.idUsuari = @user[0].id 
    @comment = Comment.where(:id => @comment_vote.idComment)
    if @comment[0].nil?
      render :json => {:error => "The comment does not exists"}.to_json, status: 404
    else
      @comment[0].points +=1
      @comment[0].save
      if @comment_vote.save
      render json: @comment_vote  
      end
    end
  end
end

def destroyCommentVoteAPI
  @user = User.where(auth_token: request.headers['ApiKeyAuth'])
  @comment_vote = CommentVote.where(:idComment => params[:id], :idUsuari => @user[0].id)
  if @comment_vote[0].nil?
    render :json => {:error => "The vote does not exist"}.to_json, status: 404
  else
    @comment = Comment.find(@comment_vote[0].idComment)
    if @comment.users_id == @user[0].id
      render :json => {:error => "You cannot delete the vote because you are the author of the comment"}.to_json, status: 403
    else
      @comment_vote[0].destroy
      @comment.points -= 1
      @comment.save
      render :json => {:message => "removed" }.to_json, status: 204
    end
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