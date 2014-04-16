# == Schema Information
#
# Table name: contracts
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  leaser_id  :integer
#  sign_date  :date
#  status     :integer          default(0)
#  duration   :integer          default(0)
#  number     :integer
#  income     :float            default(0.0)
#  rate       :float
#  created_at :datetime
#  updated_at :datetime
#

class Contract < ActiveRecord::Base
  extend Enumerize

  belongs_to :room
  belongs_to :leaser

  has_many :attachments, dependent: :destroy, class_name: ContractAttachment
  accepts_nested_attributes_for :attachments, allow_destroy: true

  enumerize :status, in: { novel: 0, approval: 1, signed:2, finished: 3 }, default: :novel
  # Доход от аренды помещения
  def title
    "#{number}"
  end

  def contract_project_download_name
    "contract_#{leaser.name}_#{room.number}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(contract_project_file_name)}"
  end

  def self.fields
    %w(number income duration sign_date rate status)
  end
end
