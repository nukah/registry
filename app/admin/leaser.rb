ActiveAdmin.register Leaser do
  menu priority: 15
  filter :contracts, as: :select
  filter :name, as: :string

  show do |leaser|
    render 'contracts', contracts: leaser.contracts, leaser: leaser
  end

  index do
    column :name do |leaser|
      link_to leaser.name, edit_admin_leaser_path(leaser)
    end
    column :contacts
    column t('contracts') do |leaser|
      link_to leaser.contracts.size, admin_leaser_path(leaser)
    end
  end
end
