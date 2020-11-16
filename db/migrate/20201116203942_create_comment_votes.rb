class CreateCommentVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_votes do |t|
      t.string :idComment
      t.string :idUsuari

      t.timestamps
    end
  end
end
