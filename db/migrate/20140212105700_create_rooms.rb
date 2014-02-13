class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :number
      t.integer :space
      t.belongs_to :level

      t.timestamps
    end
  end
end
