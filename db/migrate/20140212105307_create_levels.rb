class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :number
      t.integer :space
      t.integer :free_space, default: 0

      t.references :building, index: true

      t.attachment :floor_plan

      t.timestamps
    end
  end
end
