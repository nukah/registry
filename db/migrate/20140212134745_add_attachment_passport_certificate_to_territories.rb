class AddAttachmentPassportCertificateToTerritories < ActiveRecord::Migration
  def self.up
    change_table :territories do |t|
      t.attachment :cad_passport
      t.attachment :certificate
    end
  end

  def self.down
    drop_attached_file :territories, :cad_passport
    drop_attached_file :territories, :certificate
  end
end
