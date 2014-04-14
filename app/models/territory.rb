# == Schema Information
#
# Table name: territories
#
#  id                                :integer          not null, primary key
#  name                              :string(255)
#  address                           :string(255)
#  cad                               :integer
#  space                             :integer
#  certificate                       :string(255)
#  entity_id                         :integer
#  created_at                        :datetime
#  updated_at                        :datetime
#  cad_passport_file_name            :string(255)
#  cad_passport_content_type         :string(255)
#  cad_passport_file_size            :integer
#  cad_passport_updated_at           :datetime
#  certificate_file_name             :string(255)
#  certificate_content_type          :string(255)
#  certificate_file_size             :integer
#  certificate_updated_at            :datetime
#  passport_certificate_file_name    :string(255)
#  passport_certificate_content_type :string(255)
#  passport_certificate_file_size    :integer
#  passport_certificate_updated_at   :datetime
#  license_certificate_file_name     :string(255)
#  license_certificate_content_type  :string(255)
#  license_certificate_file_size     :integer
#  license_certificate_updated_at    :datetime
#
# Indexes
#
#  index_territories_on_entity_id  (entity_id)
#

class Territory < ActiveRecord::Base
  belongs_to :entity
  has_many :buildings

  has_attached_file :passport_certificate,
                    url: "/storage/documents/:class/:id/:filename",
                    styles: {
                      small: ['120x120>', :png]
                    },
                    path: ":rails_root/public/storage/documents/:class/:id/:filename",
                    keep_old_files: true,
                    default_url: ActionController::Base.helpers.asset_path('no_document.png')
  has_attached_file :license_certificate,
                    url: "/storage/documents/:class/:id/:filename",
                    styles: {
                      small: ['120x120>', :png]
                    },
                    path: ":rails_root/public/storage/documents/:class/:id/:filename",
                    keep_old_files: true,
                    default_url: ActionController::Base.helpers.asset_path('no_document.png')
  validates_attachment_content_type :passport_certificate, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  validates_attachment_content_type :license_certificate, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/

  def title
    "#{self.entity.name} (#{name})"
  end

  def passport_certificate_download_name
    "passport_#{self.entity.name}_#{self.name}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(self.passport_certificate_file_name)}"
  end

  def license_certificate_download_name
    "license_#{self.entity.name}_#{self.name}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(self.passport_certificate_file_name)}"
  end

  def self.fields
    %w(name address cad space certificate)
  end
end
