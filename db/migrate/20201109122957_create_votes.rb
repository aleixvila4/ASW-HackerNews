class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.string :idContrib
      t.string :idUsuario

      t.timestamps
    end
  end
end
