class CommentVotesController < ApplicationController
  before_action :set_comment_vote, only: [:show, :edit, :update, :destroy]

  # GET /comment_votes
  # GET /comment_votes.json
  def index
    @comment_votes = CommentVote.all
  end

  # GET /comment_votes/1
  # GET /comment_votes/1.json
  def show
  end

  # GET /comment_votes/new
  def new
    @comment_vote = CommentVote.new
  end

  # GET /comment_votes/1/edit
  def edit
  end

  # POST /comment_votes
  # POST /comment_votes.json
  def create
    @comment_vote = CommentVote.new(:idComment => params[:idComment], :idUsuari => params[:idUsuari])
    @comment = Comment.find(@comment_vote.idComment)
    @comment.points
    @comment.save
    if @comment_vote.save
     redirect_to request.referrer   
    else
      format.html { render :new }
      format.json { render json: @vote.errors, status: :unprocessable_entity }
    end
    
  end

  # PATCH/PUT /comment_votes/1
  # PATCH/PUT /comment_votes/1.json
  def update
    respond_to do |format|
      if @comment_vote.update(comment_vote_params)
        format.html { redirect_to @comment_vote, notice: 'Comment vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment_vote }
      else
        format.html { render :edit }
        format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_votes/1
  # DELETE /comment_votes/1.json
  def destroy
    @comment = Comment.find(@comment_vote.idComment)
    @comment_vote.destroy
    @comment.points -= 1
    @comment.save
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_vote
      @comment_vote = CommentVote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_vote_params
      params.require(:comment_vote).permit(:idComment, :idUsuari)
    end
end
