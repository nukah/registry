class Contract < ActiveRecord::Base
  belongs_to :room
  belongs_to :leaser
  monetize :income, :as => "contract_income"
  has_attached_file :contract_project,
                    url: "/storage/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension"
  validates_attachment_content_type :contract_project, content_type: /\Amsword/
  # Доход от аренды помещения
  def income
    self.room.space * self.rate
  end

  def to_s
    number
  end

  def contract_project_download_name
    "contract_#{leaser.name}_#{room.number}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(contract_project_file_name)}"
  end
end
