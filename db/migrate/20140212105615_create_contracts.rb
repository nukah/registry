class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :number
      t.float :rate
      t.belongs_to :room
      t.belongs_to :leaser
      t.timestamps
    end
  end
end
