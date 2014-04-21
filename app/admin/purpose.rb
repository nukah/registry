ActiveAdmin.register Purpose do
  menu priority: 20, parent: 'rent', label: I18n.t('page_titles.purposes')
  config.filters = false

  controller do
    def permitted_params
      params.permit(:purpose => [:name])
    end
  end

  index title: I18n.t('page_titles.purposes') do
    column :name
    default_actions
  end

  show do |purpose|
    attributes_table do
      row :name
    end
  end
end
