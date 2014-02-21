class AddAttachmentFileToContractFiles < ActiveRecord::Migration
  def self.up
    change_table :contract_files do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :contract_files, :file
  end
end
