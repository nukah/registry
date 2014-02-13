class CreateLeasers < ActiveRecord::Migration
  def change
    create_table :leasers do |t|
      t.string :name
      t.string :contacts

      t.timestamps
    end
  end
end
