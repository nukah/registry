class AddAttachmentDocumentToContracts < ActiveRecord::Migration
  def self.up
    change_table :contracts do |t|
      t.attachment :contract_project
    end
  end

  def self.down
    drop_attached_file :contracts, :contract_project
  end
end
