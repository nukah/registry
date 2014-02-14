class Room < ActiveRecord::Base
  belongs_to :level
  has_one :contract
  has_one :leaser, through: :contract


  def name
    "#{self.level.building.name.gsub!(/( )/, '-')}_#{self.level.number}_#{self.number}".downcase
  end
end
