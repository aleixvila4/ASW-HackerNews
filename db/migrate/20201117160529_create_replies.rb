class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.text :replyText
      t.references :Comments, null: false, foreign_key: true
      t.references :Users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
