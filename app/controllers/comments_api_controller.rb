class CommentsApiController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  
  def index_replies_comments
    if @flag == 0
      @replies = Reply.where(comments_id: params[:id]).order("created_at DESC")
      if @replies[0] == nil
        render :json => {"Error": "Reply not found"}.to_json, status: 404
      else
        render json: @replies
      end
    end
  end
  
  def update
    if @comment.update(comment_params)
      format.json { render :show, status: :ok, location: @comment }
    end
  end
  
  def destroyAPI
    while not Reply.find_by(comments_id: @comment.id).nil? do
      Reply.find_by(comments_id: @comment.id).destroy
    end
    @comment.destroy
      format.json { head :no_content }
  end
  

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:commentText, :contributions_id)
    end
end
