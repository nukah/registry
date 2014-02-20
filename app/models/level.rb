class Level < ActiveRecord::Base
  belongs_to :building
  has_many :rooms

  has_attached_file :floor_plan,
                    url: "/storage/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension"
  validates_attachment_content_type :floor_plan, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  # Свободная площадь на этаже
  def free_space
    self.space - self.rooms.to_a.sum(&:space)
  end

  def title
    "#{building.name} (#{number} #{I18n.t('activerecord.models.level', count: 1)})"
  end

  def to_s
    number
  end
end
