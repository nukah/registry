class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :address
      t.string :certificate
      t.references :territory, index: true

      t.timestamps
    end
  end
end
