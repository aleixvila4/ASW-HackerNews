class AddPointsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :points, :integer, default: 0
  end
end
