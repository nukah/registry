class Level < ActiveRecord::Base
  belongs_to :building
  has_many :rooms
  scope :of_building, ->(building) { where('building_id = ?', building)}

  searchable do
    integer :level_number, using: :number
    integer :level_space, using: :space
    boolean :level_plan do
      self.floor_plan.present?
    end
    integer :building, references: Building, using: :building_id
  end

  has_attached_file :floor_plan,
                    url: "/storage/documents/:class/:id/:filename",
                    styles: {
                      small: ['150x150>', :png]
                    },
                    path: ":rails_root/public/storage/documents/:class/:id/:filename",
                    default_url: ActionController::Base.helpers.asset_path('no_document.png')
  validates_attachment_content_type :floor_plan, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  # Свободная площадь на этаже
  def free_space
    self.space - self.rooms.to_a.sum(&:space)
  end

  def title
    "#{building.name if building} (#{number} #{I18n.t('activerecord.models.level', count: 1)})"
  end

  def to_s
    number
  end

  def self.fieldset
    ['number', 'space']
  end
end
