class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.string :idContrib
      t.string :idUsuari

      t.timestamps
    end
  end
end
