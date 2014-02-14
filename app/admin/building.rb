ActiveAdmin.register Building do
  scope :all, :default => true
  belongs_to :territory
  config.filters = false
  controller do
    def permitted_params
      params.permit(:building => [:name, :address, :certificate])
    end
  end

  sidebar I18n.t(:details), label: I18n.t(:details), only: [:show, :edit] do
    ul do
      li link_to(t(:levels), admin_building_levels_path(building))
    end
  end

  index do
    column :name
    column :address
    column :certificate
    column :building_income, sortable: false
    column :free_space, sortable: false
    default_actions
  end
end
