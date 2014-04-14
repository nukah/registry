# == Schema Information
#
# Table name: contracts
#
#  id                            :integer          not null, primary key
#  number                        :integer
#  rate                          :float
#  room_id                       :integer
#  leaser_id                     :integer
#  created_at                    :datetime
#  updated_at                    :datetime
#  contract_project_file_name    :string(255)
#  contract_project_content_type :string(255)
#  contract_project_file_size    :integer
#  contract_project_updated_at   :datetime
#  duration                      :integer          default(0)
#  sign_date                     :date
#  status                        :integer          default(0)
#  income                        :float
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
