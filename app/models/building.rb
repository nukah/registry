# == Schema Information
#
# Table name: buildings
#
#  id                             :integer          not null, primary key
#  name                           :string(255)
#  address                        :string(255)
#  certificate                    :string(255)
#  territory_id                   :integer
#  building_passport_file_name    :string(255)
#  building_passport_content_type :string(255)
#  building_passport_file_size    :integer
#  building_passport_updated_at   :datetime
#  total_space                    :integer          default(0)
#  free_space                     :integer          default(0)
#  income                         :float            default(0.0)
#  created_at                     :datetime
#  updated_at                     :datetime
#
# Indexes
#
#  index_buildings_on_territory_id  (territory_id)
#

class Building < ActiveRecord::Base
  belongs_to :territory
  has_many :rooms
  has_many :levels

  has_attached_file :building_passport,
                    url: "/storage/documents/:class/:id/:filename",
                    styles: {
                      small: ['150x150>', :png]
                    },
                    path: ":rails_root/public/storage/documents/:class/:id/:filename",
                    default_url: ActionController::Base.helpers.asset_path('no_document.png')
  validates_attachment_content_type :building_passport, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  monetize :income, :as => "building_income"

  def title
    territory.present? ? "#{territory.name} (#{self.name})" : name
  end

  def building_passport_download_name
    "building_passport_#{self.territory.name}_#{self.name}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(self.building_passport_file_name)}"
  end

  def self.fields
    %w(name address certificate)
  end
end
