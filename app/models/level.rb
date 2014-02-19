class Level < ActiveRecord::Base
  belongs_to :building
  has_many :rooms

  has_attached_file :floor_plan,
                    styles: { preview: ["600x800>", :png], thumbnail: ["200x200", :png] },
                    processors: [:PDFPNGProcessor, :png],
                    url: "/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension",
                    keep_old_files: true
  validates_attachment_content_type :floor_plan, content_type: /(pdf)|(png)|(tiff)|(jpeg|jpg)/
  # Свободная площадь на этаже
  def free_space
    self.space - self.rooms.to_a.sum(&:space)
  end

  def name
    number
  end
  def to_s
    number
  end
end
