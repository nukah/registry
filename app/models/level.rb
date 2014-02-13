class Level < ActiveRecord::Base
  belongs_to :building
  has_many :rooms

  private
  # Свободная площадь на этаже
  def free_space
    self.space - self.rooms.to_a.sum(&:space)
  end
end
