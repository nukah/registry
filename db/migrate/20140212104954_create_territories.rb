class CreateTerritories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.string :name
      t.string :address
      t.integer :cad
      t.integer :space
      t.string :certificate
      t.references :entity, index: true

      t.timestamps
    end
  end
end
