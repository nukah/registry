ActiveAdmin.register Room do
  menu priority: 14, parent: 'rent', label: I18n.t('page_titles.rooms')

  collection_action :filter_levels, method: :get do
    if params[:building_id]
      building = Building.find(params[:building_id])
      respond_to do |fmt|
        fmt.json { render json: building.levels }
      end
    else
      render json: {}
    end
  end

  controller do
    before_action :predefine_level, only: [:new]

    def predefine_level
      l = params[:level]
      if l && Level.exists?(l)
        @room = Room.new()
        @room.level = Level.find(l)
      else
        @room = Room.new()
      end
    end

    def permitted_params
      params.permit(:room => [:number, :space, :level_id])
    end
  end

  filter :contract
  filter :leaser
  filter :number
  filter :space

  show do |room|
    attributes_table do
      row :number
      row :space do
        space_with_metrics room.space
      end
      row :level do
        room.level.title if room.level
      end
      row t('headers.contract', count: 1) do
        room.contract if room.contract
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs t("formtastic.titles.main") do
      f.input :number
      f.input :space
      unless params[:level]
        f.input :building, as: :select, collection: Building.all
      end
      f.input :level
      f.actions
    end
  end

  index title: I18n.t('page_titles.rooms') do
    column :number do |room|
      link_to room.number, admin_room_path(room)
    end
    column :contract_number do |room|
      link_to room.contract.number, admin_contract_path(room.contract) if room.contract
    end
    column :space do |room|
      space_with_metrics room.space
    end
    column :leaser do |room|
      link_to room.leaser, admin_leaser_path(room.leaser) if room.leaser
    end
    column :building do |room|
      room.level.title if room.level
    end
    column :income do |room|
      number_to_currency room.contract.income if room.contract
    end
  end
end