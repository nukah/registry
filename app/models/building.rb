class Building < ActiveRecord::Base
  belongs_to :territory
  has_many :levels
  has_attached_file :building_passport,
                    url: "/storage/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension"
  validates_attachment_content_type :building_passport, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  monetize :income, :as => "building_income"

  def display_name
    "#{territory.name} (#{name})"
  end

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
    Contract.where(room_id: levels.map { |l| l.rooms.map(&:id) }.flatten).to_a.sum(&:income)
  end

  def building_passport_download_name
    "building_passport_#{self.territory.name}_#{self.name}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(self.building_passport_file_name)}"
  end
end
