class AddAttachmentPassportCertificateLicenseCertificateToTerritories < ActiveRecord::Migration
  def self.up
    change_table :territories do |t|
      t.attachment :passport_certificate
      t.attachment :license_certificate
    end
  end

  def self.down
    drop_attached_file :territories, :passport_certificate
    drop_attached_file :territories, :license_certificate
  end
end
