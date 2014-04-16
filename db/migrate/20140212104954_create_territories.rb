class CreateTerritories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.string :name
      t.string :address
      t.string :certificate

      t.integer :cad
      t.integer :space

      t.attachment :passport_certificate
      t.attachment :license_certificate

      t.references :entity, index: true

      t.timestamps
    end
  end
end
