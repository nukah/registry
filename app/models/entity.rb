class Entity < ActiveRecord::Base
  include VisibleAttributes

  visible :name
  has_many :territories
end
