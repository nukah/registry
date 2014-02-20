class Territory < ActiveRecord::Base
  belongs_to :entity
  has_many :buildings

  has_attached_file :passport_certificate,
                    url: "/storage/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension"
  has_attached_file :license_certificate,
                    url: "/storage/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension",
                    keep_old_files: true
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
end
