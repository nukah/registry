# == Schema Information
#
# Table name: entities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  city       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Entity < ActiveRecord::Base
  has_many :territories

  def self.fields
    %w(name city)
  end
end
