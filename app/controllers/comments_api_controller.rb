class CommentsApiController < ApplicationController
  before_action :set_comment, only: [:updateCommentAPI, :destroyCommentAPI]
  before_action :authenticate
  
  def index_user_commentsAPI
    @user = User.find(params[:id])
    @comments = Comment.where(users_id: @user.id).order("created_at DESC")
    render json: @comments
  end
  
  def show_commentAPI
    @comment = Comment.where(id: params[:id])
    if @comment[0] == nil
      render :json => {"Error": "Comment not found"}.to_json, status: 404
    else
      render json: @comment
    end
  end
  
  def index_replies_comments
    @replies = Reply.where(comments_id: params[:id]).order("created_at DESC")
    if @replies[0] == nil
      render :json => {"Error": "Replies not found"}.to_json, status: 404
    else
      render json: @replies
    end
  end
  
  def createCommentAPI
    @comment = Comment.new(comment_params)
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    @comment.users_id = @user[0].id
    @comment.contributions_id = params[:id]
    if @comment.commentText.empty?
      render :json => {:error => "The text is empty"}.to_json, status: 400
    else
      @comment.save
      @vote = CommentVote.new(:idUsuari => @user[0].id, :idComment => @comment.id)
      @vote.save
      @comment.points += 1
      @comment.save
      render json: @comment
    end
  end
  
  def updateCommentAPI
    @C = Comment.new(comment_params)
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    if @C.commentText.empty?
      render :json => {:error => "The text is empty"}.to_json, status: 400
    elsif @comment.users_id != @user[0].id
      render :json => {:error => "Unauthorized user"}.to_json, status: 401
    elsif @comment.update(comment_params)
      render json: @comment
    end
  end
  
  def destroyCommentAPI
    @user = User.where(auth_token: request.headers['ApiKeyAuth'])
    if @user[0].id != @comment.users_id
     render :json => {:error => "Unauthorized user"}.to_json, status: 401
    else
      while not Reply.find_by(comments_id: @comment.id).nil? do
        Reply.find_by(comments_id: @comment.id).destroy
      end
      while not CommentVote.find_by(idComment: @comment.id).nil? do
        CommentVote.find_by(idComment: @comment.id).destroy
      end
      @comment.destroy
      render :json => {:message => "removed"}.to_json, status: 204
    end
  end
  

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comments_api).permit(:commentText, :contributions_id)
    end
end
