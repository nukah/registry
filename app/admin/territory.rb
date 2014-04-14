ActiveAdmin.register Territory do
  menu priority: 11, parent: 'rent'
  action_item only: :show do
    link_to(t('active_admin.add_model', model: t('activerecord.models.building', count: 1)), new_admin_building_path(territory: resource.id))
  end
  controller do
    def permitted_params
      params.permit(:territory => [:name, :address, :cad, :space, :certificate, :passport_certificate, :license_certificate])
    end
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
    render "buildings", buildings: territory.buildings
  end

  index do
    column :name do |territory|
      link_to territory.name, admin_territory_path(territory)
    end
    column :address
    column :cad
    column :space do |territory|
      space_with_metrics territory.space
    end
    column t('headers.buildings') do |territory|
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

  form do |f|
    f.inputs t('forms.chapters.main') do
      f.input :entity, as: :select
      f.input :name
      f.input :space
    end
    f.inputs t('forms.chapters.additional') do
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
