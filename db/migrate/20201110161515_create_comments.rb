class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :commentText
      t.references :Contributions, null: false, foreign_key: true
      t.references :Users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
