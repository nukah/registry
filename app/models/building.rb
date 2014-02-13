class Building < ActiveRecord::Base
  belongs_to :territory
  has_many :levels

  monetize :income, :as => "building_income"

  private
  # Суммарная площадь пространства
  def space
    self.levels.to_a.sum(&:space)
  end
  # Количество свободного арендного пространства
  def free_space
    self.levels.to_a.sum(&:free_space)
  end

  # Доход от аренды по зданию
  def income
    Contract.where(room_id: self.levels.map { |l| l.rooms.map(&:id) }.flatten).to_a.sum(&:income)
  end
end
