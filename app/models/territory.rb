class Territory < ActiveRecord::Base
  belongs_to :entity
  has_many :buildings

  searchable do
    string :territory_name, using: :name
    string :territory_address, using: :address
    integer :territory_cad, using: :cad
    integer :territory_space, using: :space
    integer :territory_certificate, using: :certificate
    integer :entity, references: Entity, using: :entity_id
  end

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
                      small: '120x120>'
                    },
                    path: ":rails_root/public/storage/documents/:class/:id/:filename",
                    keep_old_files: true,
                    default_url: ActionController::Base.helpers.asset_path('no_document.png')
  validates_attachment_content_type :passport_certificate, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  validates_attachment_content_type :license_certificate, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/

  def display_name
    "#{self.entity.name} (#{name})"
  end

  def passport_certificate_download_name
    "passport_#{self.entity.name}_#{self.name}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(self.passport_certificate_file_name)}"
  end

  def license_certificate_download_name
    "license_#{self.entity.name}_#{self.name}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(self.passport_certificate_file_name)}"
  end

  def self.fieldset
    ['name','address', 'cad', 'space', 'certificate']
  end
end
