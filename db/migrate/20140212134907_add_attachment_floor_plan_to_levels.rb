class AddAttachmentFloorPlanToLevels < ActiveRecord::Migration
  def self.up
    change_table :levels do |t|
      t.attachment :floor_plan
    end
  end

  def self.down
    drop_attached_file :levels, :floor_plan
  end
end
