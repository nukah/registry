class Room < ActiveRecord::Base
  belongs_to :level
  has_one :contract
  has_one :leaser, through: :contract

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
