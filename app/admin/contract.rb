ActiveAdmin.register Contract do
  menu priority: 16
  #belongs_to :leaser

  member_action :download_contract_project, method: :get do
    c = Contract.find(params[:id])
    require 'zip'
    temp = Tempfile.new("#{Time.now.to_i}_#{number}")
    Zip::ZipOutputStream.open(temp) do |zip|
      c.contract_files.map(&:file).select(*:exists?).each { |file|
        filename = File.basename(file.path)
        zip.put_next_entry filename
        zip.print IO.read(file.path)
      }
    end
    send_file temp.path, type: 'application/zip', filename: "contract_#{number}_#{leaser.name}_#{room.number}_#{sign_date.strftime('%d-%m-%Y')}.zip"
    temp.delete
  end

  index do
    column :room do |contract|
      link_to contract.room.number, admin_room_path(contract.room)
    end
    column :number
    column :rate do |contract|
      number_to_currency contract.income
    end
    column :sign_date
    column :status
    column :duration
    column do |contract|
      link_to t(:contract_project), admin_contract_path(contract)
    end
  end

  filter :leaser
  filter :number, as: :string
  filter :rate, as: :numeric
  filter :status, as: :select
  filter :duration
end
