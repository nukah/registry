ActiveAdmin.register Entity do
  config.filters = false
  menu priority: 10
  controller do
    def permitted_params
      params.permit(:entity => [:name, :city])
    end
  end
  form do |f|
    f.inputs t('forms.chapters.main')
    f.input :name
    f.input :city
    f.inputs t('forms.actions') do
      f.actions do
        f.action :submit
        f.action :cancel
      end
    end
  end
  show do |entity|
    render "territories", territories: entity.territories, entity: entity
  end
  index do
    column :name do |entity|
      link_to entity.name, edit_admin_entity_path(entity)
    end
    column :city
    column t('headers.territories') do |entity|
      link_to entity.territories.size, admin_entity_path(entity)
    end
  end
end
