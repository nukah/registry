class AddStatusEnumToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :status, :integer, default: 0
  end
end
