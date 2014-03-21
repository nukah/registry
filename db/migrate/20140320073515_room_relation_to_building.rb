class RoomRelationToBuilding < ActiveRecord::Migration
  def change
    change_table :rooms do |t|
      t.references :building, index: true
    end
  end
end
