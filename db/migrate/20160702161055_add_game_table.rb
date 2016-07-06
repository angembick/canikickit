class AddGameTable < ActiveRecord::Migration
  def change
    create_table (:games) do |t|
      t.integer :utc_offset
      t.integer :rsvp_limit
      t.float :distance
      t.float :fee_amount
      t.integer :yes_rsvp_count
      t.integer :duration
      t.string :name
      t.string :game_id 
      t.integer :time
      t.integer :game_updated
      t.string :group_name
      t.float :group_lon
      t.float :group_lat
      t.integer :group_id
      t.string :group_urlname
      t.string :group_who
      t.string :status
      t.string :day_of_the_week

      t.timestamps
    end
  end
end