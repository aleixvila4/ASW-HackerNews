class RepliesController < ApplicationController
before_action :set_reply, only: [:show, :edit, :update, :destroy]

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
