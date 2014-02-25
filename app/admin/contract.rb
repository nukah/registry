require 'zip'
ActiveAdmin.register Contract do
  menu priority: 16, parent: 'rent'
  #belongs_to :leaser
  controller do
    def permitted_params
      params.permit(contract: [:number, :room_id, :rate, :leaser_id, :sign_date, :duration, :status, :attachments,
                    attachments_attributes: [:file, :_destroy, :id]
                    ])
    end
  end
  member_action :download_contract_project, method: :get do
    c = Contract.find(params[:id])
    temp = Tempfile.new("#{Time.now.to_i}_#{c.number}")
    Zip::OutputStream.open(temp) do |zip|
      c.attachments.map(&:file).select(&:exists?).each { |file|
        filename = File.basename(file.path)
        zip.put_next_entry filename
        zip.print IO.read(file.path)
      }
    end
    send_file temp.path, type: 'application/zip', filename: "contract_#{c.number}_#{c.leaser.name}_#{c.room.number}_#{c.sign_date.strftime('%d-%m-%Y')}.zip"
  end

  show do |contract|
    attributes_table do
      row :number
      row :room
      row :rate do
        number_to_currency contract.rate
      end
      row :leaser
      row :sign_date
      row :duration do
        duration_with_metrics contract.duration
      end
      row :status do
        status_tag contract.status_text
      end
    end
    if contract.attachments.any?
      panel "Files" do
        table_for contract.attachments do
          column t('activerecord.attributes.contract.attachment.name') do |a|
            a.file_file_name
          end
          column t('activerecord.attributes.contract.attachment.size') do |a|
            number_to_human_size(a.file_file_size)
          end
        end
        link_to 'Download all', download_contract_project_admin_contract_path(contract)
      end
    end
  end

  form partial: "edit_contract"

  index do
    column :room do |contract|
      link_to contract.room.number, admin_room_path(contract.room)
    end
    column :number do |contract|
      link_to contract.number, admin_contract_path(contract)
    end
    column :rate do |contract|
      number_to_currency contract.income
    end
    column :sign_date
    column :status do |contract|
      status_tag contract.status_text, :ok
    end
    column :duration do |contract|
      duration_with_metrics contract.duration
    end
    column t('contract_documents') do |contract|
      link_to contract.attachments.size, download_contract_project_admin_contract_path(contract) if contract.attachments.any?
    end
  end

  filter :leaser
  filter :number, as: :string
  filter :rate, as: :numeric
  filter :sign_date
  filter :status, as: :select
  filter :duration
end
