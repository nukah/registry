ActiveAdmin.register Entity do
  config.filters = false
  controller do
    def permitted_params
      params.permit(:entity => [:name, :city])
    end
  end
  sidebar I18n.t(:details), label: I18n.t(:details), only: [:show, :edit] do
    ul do
      li link_to(t(:territories), admin_entity_territories_path(entity))
    end
  end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

end