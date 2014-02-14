class AddAttachmentBuildingPassportToBuildings < ActiveRecord::Migration
  def self.up
    change_table :buildings do |t|
      t.attachment :building_passport
    end
  end

  def self.down
    drop_attached_file :buildings, :building_passport
  end
end
