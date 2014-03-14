class Building < ActiveRecord::Base
  belongs_to :territory
  has_many :levels
  searchable do
    integer :building_space do
      levels.to_a.sum(&:space)
    end
    integer :building_free_space do
      levels.to_a.sum(&:free_space)
    end
    text :building_address, using: :address
    text :building_name, using: :name
    integer :building_income do
      Contract.where(room_id: levels.map { |l| l.rooms.map(&:id) }.flatten).to_a.sum(&:income)
    end
    string :territory, references: Territory, using: :territory_id
  end

  has_attached_file :building_passport,
                    url: "/storage/documents/:class/:id/:filename",
                    styles: {
                      small: ['150x150>', :png]
                    },
                    path: ":rails_root/public/storage/documents/:class/:id/:filename",
                    default_url: ActionController::Base.helpers.asset_path('no_document.png')
  validates_attachment_content_type :building_passport, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  monetize :income, :as => "building_income"

  def display_name
    territory.present? ? "#{territory.name} (#{self.name})" : name
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

  def self.fieldset
    ['name','address', 'certificate']
  end
end
