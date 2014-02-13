class AddAttachmentDocumentToContracts < ActiveRecord::Migration
  def self.up
    change_table :contracts do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :contracts, :document
  end
end
