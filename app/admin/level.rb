ActiveAdmin.register Level do
  config.filters = false
  menu priority: 13
  controller do
    before_action :predefine_building, only: [:new]

    def predefine_building
      b = params[:building]
      if b && Building.exists?(b)
        @level = Level.new()
        @level.building = Building.find(b)
      else
        @level = Level.new()
      end
    end
    def permitted_params
      params.permit(:level => [:number, :space, :building])
    end
  end

  form do |f|
    f.inputs t("forms.chapters.main") do
      f.input :building, as: :select
      f.input :number
      f.input :space
    end

    f.inputs t("forms.chapters.additional") do
      f.input :floor_plan, as: :file
    end

    f.actions
  end
  sidebar I18n.t(:details), label: I18n.t(:details), only: [:show, :edit] do
    ul do
      li link_to(t(:rooms), admin_level_rooms_path(level))
    end
  end
end
