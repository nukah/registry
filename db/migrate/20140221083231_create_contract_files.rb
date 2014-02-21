class CreateContractFiles < ActiveRecord::Migration
  def change
    create_table :contract_files do |t|
      t.belongs_to :contract
      t.timestamps
    end
  end
end
