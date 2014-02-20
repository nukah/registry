ActiveAdmin.register Contract do
  menu priority: 16
  #belongs_to :leaser

  member_action :download_contract_project, method: :get do
    contract = Contract.find(params[:id])
    send_file contract.contract_project.path,
              type: contract.contract_project_content_type,
              filename: contract.contract_project_download_name
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
