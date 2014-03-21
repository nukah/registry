# == Schema Information
#
# Table name: levels
#
#  id                      :integer          not null, primary key
#  number                  :integer
#  space                   :integer
#  building_id             :integer
#  created_at              :datetime
#  updated_at              :datetime
#  floor_plan_file_name    :string(255)
#  floor_plan_content_type :string(255)
#  floor_plan_file_size    :integer
#  floor_plan_updated_at   :datetime
#  free_space              :integer          default(0)
#
# Indexes
#
#  index_levels_on_building_id  (building_id)
#

class Level < ActiveRecord::Base
  belongs_to :building
  has_many :rooms

  has_attached_file :floor_plan,
                    url: "/storage/documents/:class/:id/:filename",
                    styles: {
                      small: ['150x150>', :png]
                    },
                    path: ":rails_root/public/storage/documents/:class/:id/:filename",
                    default_url: ActionController::Base.helpers.asset_path('no_document.png')
  validates_attachment_content_type :floor_plan, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/

  # Свободная площадь на этаже
  def title
    "#{building.name if building} (#{number} #{I18n.t('activerecord.models.level', count: 1)})"
  end

  def self.fields
    %w(number space)
  end
end
