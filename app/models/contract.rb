class Contract < ActiveRecord::Base
  belongs_to :room
  belongs_to :leaser
  monetize :income, :as => "contract_income"
  has_attached_file :contract_project,
                    url: "/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension",
                    keep_old_files: true
  validates_attachment_content_type :contract_project, content_type: /\Amsword/
  # Доход от аренды помещения
  def income
    self.room.space * self.rate
  end

  def to_s
    number
  end
end
