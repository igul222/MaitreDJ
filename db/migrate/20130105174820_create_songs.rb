class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :venue
      t.string :query

      t.timestamps
    end
  end
end
