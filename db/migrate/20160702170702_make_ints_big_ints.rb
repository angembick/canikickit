class MakeIntsBigInts < ActiveRecord::Migration
  def change
      change_column :games,  :utc_offset, :integer, limit: 8
      change_column :games,  :duration, :integer, limit: 8
      change_column :games,  :time, :integer, limit: 8
      change_column :games,  :game_updated, :integer, limit: 8
  end
end
