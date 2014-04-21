# == Schema Information
#
# Table name: rooms
#
#  id          :integer          not null, primary key
#  number      :integer
#  space       :integer
#  level_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#  building_id :integer
#
# Indexes
#
#  index_rooms_on_building_id  (building_id)
#

class Room < ActiveRecord::Base
  belongs_to :level
  belongs_to :building

  has_one :contract
  has_one :leaser, through: :contract

  def title
    if self.level.present?
      "#{self.level.title}_#{self.number}".downcase
    else
      "#{self.number}".downcase
    end
  end

  def self.fields
    %w(number space)
  end
end
