class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(reply_params)
    if (current_user)
      @reply.users_id = current_user.id
      respond_to do |format|
        if @reply.save
          @vote = ReplyVote.new(:idUsuari => current_user.id, :idReply => @reply.id)
          @vote.save
          @reply.points += 1
          @reply.save
          format.html { redirect_to request.referrer }
          format.json { render :show, status: :created, location: @reply }
        else
          format.html { render :new }
          format.json { render json: @reply.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to "/auth/google_oauth2"
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    @comment = Comment.find_by(id: @reply.comments_id)
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @comment, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_params
      params.require(:reply).permit(:replyText, :comments_id, :users_id)
    end
end
