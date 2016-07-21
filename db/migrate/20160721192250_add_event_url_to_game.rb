class AddEventUrlToGame < ActiveRecord::Migration
  def change
    add_column :games, :event_url, :string
  end
end
