class CreateUsuaris < ActiveRecord::Migration[6.0]
  def change
    create_table :usuaris do |t|

      t.timestamps
    end
  end
end
