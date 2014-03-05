class Entity < ActiveRecord::Base
  has_many :territories

  def self.fieldset
    ['name','city']
  end
end
