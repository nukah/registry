require 'zip'
ActiveAdmin.register Contract do
  menu priority: 16
  #belongs_to :leaser
  controller do
    def permitted_params
      params.permit(contract: [:number, :room_id, :rate, :leaser_id, :sign_date, :duration, :status, :attachments,
                    attachments_attributes: [:file]
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
      panel t('headers.contract_attachments') do
        contract.attachments.each do |a|
          div do
            span do
             "name: #{a.file_file_name}"
            end
            span do
              "size: #{number_to_human_size(a.file_file_size)}"
            end
          end
        end
      end
    end
  end

  form multipart: true do |f|
    f.inputs t('forms.chapters.main') do
      f.input :room
      f.input :leaser
      f.input :rate, as: :number
    end
    f.inputs t('forms.chapters.additional') do
      f.input :number
      f.input :sign_date, as: :datepicker
      f.input :status, as: :select
      f.input :duration, as: :number
    end
    f.has_many :attachments do |ff|
      if ff.object.present?
        ff.template.inspect
      else
        ff.input :file, as: :file, hint: "#{ff.object.file_file_name}"
      end
      ff.input :_destroy, as: :boolean, required: false, label: t('formtastic.actions.destroy')
    end

    f.actions
  end

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
    column do |contract|
      link_to t(:contract_project), download_contract_project_admin_contract_path(contract)
    end
  end

  filter :leaser
  filter :number, as: :string
  filter :rate, as: :numeric
  filter :status, as: :select
  filter :duration
end
