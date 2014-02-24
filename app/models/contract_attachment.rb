class ContractAttachment < ActiveRecord::Base
  belongs_to :contract

  after_save :update_parent
  has_attached_file :file,
                    url: "/storage/documents/:class/:id/:filename.:extension",
                    path: ":rails_root/public/storage/documents/:class/:id/:filename.:extension"
  validates_attachment_content_type :file, content_type: /(pdf)|(msword)/

  def update_parent
    contract.touch
  end
end
