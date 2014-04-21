ActiveAdmin.register Territory do
  menu priority: 11, parent: 'rent', label: I18n.t('page_titles.territory')
  action_item only: :show do
    link_to(t('active_admin.add_model', model: t('activerecord.models.building', count: 1)), new_admin_building_path(territory: resource.id))
  end
  controller do
    before_action :predefine_entity, only: [:new]

    def predefine_entity
      e = params[:entity]
      if e && Entity.exists?(e)
        @territory = Territory.new
        @territory.entity = Entity.find(e)
      else
        @territory = Territory.new
      end
    end
  end

  member_action :download_passport_certificate, method: :get do
    t = Territory.find(params[:id])
    send_file t.passport_certificate.path, type: t.passport_certificate_content_type, filename: t.passport_certificate_download_name
  end
  member_action :download_license_certificate, method: :get do
    t = Territory.find(params[:id])
    send_file t.license_certificate.url, type: t.license_certificate_content_type, filename: t.license_certificate_download_name
  end

  show do |territory|
    render "buildings", buildings: territory.buildings, territory: territory
  end

  index title: I18n.t('page_titles.territories') do
    column :name do |territory|
      link_to territory.name, admin_territory_path(territory)
    end
    column :address
    column :cad
    column :space do |territory|
      space_with_metrics_hectars territory.space
    end
    column t('headers.entity', count: 1) do |territory|
      territory.entity.name
    end
    column t('headers.building', count: 5) do |territory|
      territory.buildings.size
    end
    column t(:license_certificate) do |territory|
      download_links([:license_certificate, :passport_certificate], territory)
    end
  end

  filter :name
  filter :address
  filter :cad
  filter :space
  filter :certificate
  filter :entity

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs t('formtastic.titles.main') do
      f.input :entity, as: :select
      f.input :name
      f.input :space
    end
    f.inputs t('formtastic.titles.additional') do
      f.input :address
      f.input :cad
      f.input :certificate
      f.input :passport_certificate, as: :file, hint: f.template.image_tag(f.object.passport_certificate.url(:small), class: 'attachment_image')
      f.input :license_certificate, as: :file, hint: f.template.image_tag(f.object.license_certificate.url(:small), class: 'attachment_image')
    end
    f.actions do
      f.action :submit
      f.action :cancel
    end
  end
end
