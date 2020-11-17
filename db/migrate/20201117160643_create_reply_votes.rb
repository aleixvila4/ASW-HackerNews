class CreateReplyVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :reply_votes do |t|
      t.string :idReply
      t.string :idUsuari

      t.timestamps
    end
  end
end
