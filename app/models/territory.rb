class Territory < ActiveRecord::Base
  belongs_to :entity
  has_many :buildings

  has_attached_file :passport_certificate,
                    styles: { preview: ["600x800>", :png], thumbnail: ["200x200", :png] },
                    processors: [:PDFPNGProcessor, :png],
                    url: "/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension",
                    keep_old_files: true
  has_attached_file :license_certificate,
                    styles: { preview: ["600x800>", :png], thumbnail: ["200x200", :png] },
                    processors: [:PDFPNGProcessor, :png],
                    url: "/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension",
                    keep_old_files: true
  validates_attachment_content_type :passport_certificate, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  validates_attachment_content_type :license_certificate, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/

end
