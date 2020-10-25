class CreateContributions < ActiveRecord::Migration[6.0]
  def change
    create_table :contributions do |t|
      t.string :title
      t.string :author
      t.text :url
      t.string :text

      t.timestamps
    end
  end
end
