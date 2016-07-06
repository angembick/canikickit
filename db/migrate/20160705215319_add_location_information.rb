class AddLocationInformation < ActiveRecord::Migration
  def change
    add_column :games, :loc_lat, :float
    add_column :games, :loc_lon, :float
    add_column :games, :loc_name, :string
  end
end
