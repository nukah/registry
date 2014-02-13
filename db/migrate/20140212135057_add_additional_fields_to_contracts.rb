class AddAdditionalFieldsToContracts < ActiveRecord::Migration
  def change
    change_table :contracts do |t|
      t.integer :duration
      t.date :sign_date
    end
  end
end
