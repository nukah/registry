ActiveAdmin.register Level do
  belongs_to :building
  config.filters = false
  controller do
    def permitted_params
      params.permit(:level => [:number, :space])
    end
  end
  sidebar I18n.t(:details), label: I18n.t(:details), only: [:show, :edit] do
    ul do
      li link_to(t(:rooms), admin_level_rooms_path(level))
    end
  end
end
