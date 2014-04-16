ActiveAdmin.register Level do
  config.filters = false
  menu false
  action_item only: :show do
    link_to(t('active_admin.add_model', model: t('activerecord.models.room', count: 1)), new_admin_room_path(level: resource.id))
  end
  controller do
    def permitted_params
      params.permit(:level => [:number, :space, :building_id])
    end

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

    def index
      redirect_to admin_buildings_path
    end
  end

  collection_action :building_levels, method: :get do
    levels = Hash[Level.of_building(params[:building_id]).map { |l| [l.title,l.id]}].to_json
    render json: levels
  end

  show do |level|
    render "rooms", rooms: level.rooms, level: level
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs t("forms.chapters.main") do
      f.input :building, as: :select
      f.input :number
      f.input :space
    end

    f.inputs t("forms.chapters.additional") do
      f.input :floor_plan, as: :file, hint: f.template.image_tag(f.object.floor_plan.url(:small), class: 'attachment_image')
    end

    f.actions
  end
end
