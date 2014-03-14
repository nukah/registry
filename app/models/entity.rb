class Entity < ActiveRecord::Base
  has_many :territories

  searchable do
    text :name
    text :city
  end

  def self.fieldset
    ['name','city']
  end
end
