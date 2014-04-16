class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :room
      t.belongs_to :leaser

      t.date :sign_date

      t.integer :status, default: 0
      t.integer :duration, default: 0
      t.integer :number

      t.float :income, default: 0
      t.float :rate

      t.timestamps
    end
  end
end
