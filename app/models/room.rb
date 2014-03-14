class Room < ActiveRecord::Base
  belongs_to :level
  has_one :contract
  has_one :leaser, through: :contract

  searchable do
    integer :room_space, using: :space
    integer :room_number, using: :number
    integer :level, references: Level, using: :level_id
  end

  def building
    level.building if level
  end

  def name
    "#{self.level.building.name.gsub!(/( )/, '-')}_#{self.level.number}_#{self.number}".downcase
  end

  def self.fieldset
    ['number', 'space']
  end
end
