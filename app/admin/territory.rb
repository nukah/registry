ActiveAdmin.register Territory do
  scope :all, :default => true
  belongs_to :entity
  controller do
    def permitted_params
      params.permit(:territory => [:name, :address, :cad, :space, :certificate])
    end
  end
  permit_params :name, :address, :cad, :space, :certificate

  sidebar I18n.t(:details), label: I18n.t(:details), only: [:show, :edit] do
    ul do
      li link_to(t(:buildings), admin_territory_buildings_path(territory))
    end
  end
  # Customize columns displayed on the index screen in the table
  index do
    column :name
    column :address
    default_actions
  end
end
