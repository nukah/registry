class AddAttachmentTechnicalPassportToBuildings < ActiveRecord::Migration
  def self.up
    change_table :buildings do |t|
      t.attachment :technical_passport
    end
  end

  def self.down
    drop_attached_file :buildings, :technical_passport
  end
end
