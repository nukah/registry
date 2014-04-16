class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :address
      t.string :certificate

      t.references :territory, index: true

      t.attachment :building_passport

      t.integer :total_space, default: 0
      t.integer :free_space, default: 0

      t.float :income, default: 0.0

      t.timestamps
    end
  end
end
