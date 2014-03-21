class CreateAggregationColumns < ActiveRecord::Migration
  def change
    change_table :levels do |t|
      t.integer :free_space, default: 0
    end

    change_table :buildings do |t|
      t.integer :total_space, default: 0
      t.integer :free_space, default: 0
      t.float :income
    end

    change_table :contracts do |t|
      t.float :income
    end
  end
end
