# == Schema Information
#
# Table name: purposes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Purpose < ActiveRecord::Base
end
