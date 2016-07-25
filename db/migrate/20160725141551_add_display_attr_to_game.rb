class AddDisplayAttrToGame < ActiveRecord::Migration
  def change
    add_column :games, :display, :bool
  end
end
