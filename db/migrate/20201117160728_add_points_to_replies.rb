class AddPointsToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :points, :integer, default:0
  end
end
