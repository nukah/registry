class CreateContractAttachments < ActiveRecord::Migration
  def change
    create_table :contract_attachments do |t|
      t.belongs_to :contract
      t.attachment :file
      t.timestamps
    end
  end
end
