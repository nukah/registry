class Contract < ActiveRecord::Base
  extend Enumerize

  belongs_to :room
  belongs_to :leaser
  has_many :attachments, dependent: :destroy, class_name: ContractAttachment
  accepts_nested_attributes_for :attachments, allow_destroy: true
  enumerize :status, in: { novel: 0, approval: 1, signed:2, finished: 3 }, default: :novel
  searchable do
    integer :number
    integer :income do
      self.room.space * self.rate
    end
    integer :duration
    time :sign_date
    integer :rate
    integer :status
    integer :room_id, references: Room
    integer :leaser_id, references: Leaser
  end

  # Доход от аренды помещения
  def income
    self.room.space * self.rate
  end

  def title
    "#{number}"
  end

  def contract_project_download_name
    "contract_#{leaser.name}_#{room.number}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(contract_project_file_name)}"
  end

  def self.fieldset
    ['number', 'income', 'duration', 'sign_date', 'rate', 'status']
  end
end
