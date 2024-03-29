class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index_user_comments
    @user = User.find(params[:user])
    @comments = Comment.where(users_id: @user.id).order("created_at DESC")
  end
  
  def index_voted_user_comments
    @comments = Comment.all.order("created_at DESC")
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @reply = Reply.new
    @replies = Reply.where(comments_id: @comment.id).order("created_at DESC")
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    if (current_user)
      @comment.users_id = current_user.id
      respond_to do |format|
        if @comment.save
          @vote = CommentVote.new(:idUsuari => current_user.id, :idComment => @comment.id)
          @vote.save
          @comment.points += 1
          @comment.save
          format.html { redirect_to request.referrer }
          format.json { render :show, status: :created, location: @comment.contribution_id }
        else
          format.html { redirect_to comments_url }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/auth/google_oauth2"
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    while not Reply.find_by(comments_id: @comment.id).nil? do
      Reply.find_by(comments_id: @comment.id).destroy
    end
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
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
