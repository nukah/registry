class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :number
      t.integer :space
      t.references :level
      t.references :building, index: true
      t.timestamps
    end
  end
end
