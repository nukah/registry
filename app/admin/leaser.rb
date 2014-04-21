ActiveAdmin.register Leaser do
  menu priority: 15, parent: 'rent', label: I18n.t('page_titles.leasers')

  filter :contracts, as: :select
  filter :name, as: :string

  controller do
    def permitted_params
      params.permit(:leaser => [:name, :contacts])
    end
  end

  show do |leaser|
    render 'contracts', contracts: leaser.contracts, leaser: leaser
  end

  index title: I18n.t('page_titles.leasers') do
    column :name do |leaser|
      link_to leaser.name, admin_leaser_path(leaser)
    end
    column :contacts
    column t('contracts') do |leaser|
      leaser.contracts.size
    end
  end
end
