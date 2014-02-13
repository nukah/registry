class Room < ActiveRecord::Base
  belongs_to :level
  has_one :contract
  has_one :leaser, through: :contract
end
