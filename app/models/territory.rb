class Territory < ActiveRecord::Base
  belongs_to :entity
  has_many :buildings
end
