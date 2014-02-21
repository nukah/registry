class Contract < ActiveRecord::Base
  belongs_to :room
  belongs_to :leaser
  has_many :contract_files
  monetize :income, :as => "contract_income"
  # Доход от аренды помещения
  def income
    self.room.space * self.rate
  end

  def all_attachments
    require 'zip'
    temp = Tempfile.new("#{Time.now.to_i}_#{number}")
    Zip::ZipOutputStream.open(temp) do |zip|
      contract_files.map(&:file).select(*:exists?).each { |file|
        filename = File.basename(file.path)
        zip.put_next_entry filename
        zip.print IO.read(file.path)
      }
    end
    send_file temp.path, type: 'application/zip', filename: "contract_#{number}_#{leaser.name}_#{room.number}_#{sign_date.strftime('%d-%m-%Y')}.zip"
    temp.delete
  end

  def to_s
    number
  end

  def contract_project_download_name
    "contract_#{leaser.name}_#{room.number}_#{DateTime.now.strftime("%d-%m-%y")}#{File.extname(contract_project_file_name)}"
  end

  private

  def attachments
    contract_files.map { |file| file.path }
  end

end
