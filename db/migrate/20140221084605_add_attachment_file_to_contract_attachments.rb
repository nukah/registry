class AddAttachmentFileToContractAttachments < ActiveRecord::Migration
  def self.up
    change_table :contract_attachments do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :contract_attachments, :file
  end
end
