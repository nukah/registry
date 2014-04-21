ActiveAdmin.register Entity do
  config.filters = false
  menu priority: 10, parent: 'rent', label: I18n.t('page_titles.entity')
  action_item only: :show do
    link_to(t('active_admin.add_model', model: t('activerecord.models.territory', count: 1)), new_admin_territory_path(entity: resource.id))
  end

  controller do
    def permitted_params
      params.permit(:entity => [:name, :city])
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs t('formtastic.titles.main')
    f.input :name
    f.input :city
    f.actions
  end

  show do |entity|
    render "territories", territories: entity.territories, entity: entity
  end

  index title: I18n.t('page_titles.entities') do
    column :name do |entity|
      link_to entity.name, admin_entity_path(entity)
    end
    column :city
    column t('headers.territory', count: 5) do |entity|
      entity.territories.size
    end
  end
end
