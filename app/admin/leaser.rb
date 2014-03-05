ActiveAdmin.register Leaser do
  menu priority: 15, parent: 'rent'
  filter :contracts, as: :select
  filter :name, as: :string

  show do |leaser|
    render 'contracts', contracts: leaser.contracts, leaser: leaser
  end

  index do
    column :name do |leaser|
      link_to leaser.name, admin_leaser_path(leaser)
    end
    column :contacts
    column t('contracts') do |leaser|
      leaser.contracts.size
    end
  end
end
