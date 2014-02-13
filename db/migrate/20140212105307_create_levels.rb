class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :number
      t.integer :space
      t.references :building, index: true

      t.timestamps
    end
  end
end
