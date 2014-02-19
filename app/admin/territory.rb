ActiveAdmin.register Territory do
  scope :all, :default => true
  menu priority: 11
  controller do
    def permitted_params
      params.permit(:territory => [:name, :address, :cad, :space, :certificate])
    end
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
    column :space
    column t('headers.buildings') do |territory|
      link_to territory.buildings.size, admin_territory_path(territory)
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
