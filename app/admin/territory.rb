ActiveAdmin.register Territory do
  menu priority: 11
  controller do
    def permitted_params
      params.permit(:territory => [:name, :address, :cad, :space, :certificate, :passport_certificate, :license_certificate])
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
      link_to territory.name, edit_admin_territory_path(territory)
    end
    column :address
    column :cad
    column :space do |territory|
      space_with_metrics territory.space
    end
    column t('headers.buildings') do |territory|
      link_to territory.buildings.size, admin_territory_path(territory)
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
    f.inputs t('forms.territory.main') do
      f.input :entity, as: :select
      f.input :name
      f.input :space
    end
    f.inputs t('forms.territory.additional') do
      f.input :address
      f.input :cad
      f.input :certificate
      f.input :passport_certificate, as: :file
      f.input :license_certificate, as: :file
    end
    f.actions do
      f.action :submit
      f.action :cancel
    end
  end
end
