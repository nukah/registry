class AddAdditionalFieldsToContracts < ActiveRecord::Migration
  def change
    change_table :contracts do |t|
      t.integer :duration, default: 0
      t.date :sign_date
    end
  end
end
