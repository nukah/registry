ActiveAdmin.register Leaser do
  menu priority: 15
  filter :contracts, as: :select
  filter :name, as: :string
  sidebar I18n.t(:details), label: I18n.t(:details), only: [:show, :edit] do
    ul do
      li link_to(t(:contracts), admin_leaser_contracts_path(leaser))
    end
  end

  index do
    column :name do |leaser|
      link_to leaser.name, edit_admin_leaser_path(leaser)
    end
    column :contacts
    column t('contracts') do |leaser|
      link_to leaser.contracts.size, admin_leaser_contracts_path(leaser)
    end
  end
end
