class ReplyVotesController < ApplicationController
  before_action :set_reply_vote, only: [:show, :edit, :update, :destroy]

  # GET /reply_votes
  # GET /reply_votes.json
  def index
    @reply_votes = ReplyVote.all
  end

  # GET /reply_votes/1
  # GET /reply_votes/1.json
  def show
  end

  # GET /reply_votes/new
  def new
    @reply_vote = ReplyVote.new
  end

  # GET /reply_votes/1/edit
  def edit
  end

  # POST /reply_votes
  # POST /reply_votes.json
  def create
    @reply_vote = ReplyVote.new(:idReply => params[:idReply], :idUsuari => params[:idUsuari])
    @reply = Reply.find(@reply_vote.idReply)
    @reply.points += 1
    @reply.save
      if @reply_vote.save
        redirect_to request.referrer 
      else
        format.html { render :new }
        format.json { render json: @reply_vote.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /reply_votes/1
  # PATCH/PUT /reply_votes/1.json
  def update
    respond_to do |format|
      if @reply_vote.update(reply_vote_params)
        format.html { redirect_to @reply_vote, notice: 'Reply vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply_vote }
      else
        format.html { render :edit }
        format.json { render json: @reply_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reply_votes/1
  # DELETE /reply_votes/1.json
  def destroy
    @reply = Reply.find(@reply_vote.idReply)
    @reply_vote.destroy
    @reply.points -= 1
    @reply.save
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply_vote
      @reply_vote = ReplyVote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_vote_params
      params.require(:reply_vote).permit(:idReply, :idUsuari)
    end
end
