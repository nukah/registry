ActiveAdmin.register Room do
  menu priority: 14, parent: 'rent'
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
      params.permit(:room => [:number, :space])
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
      row :level
      row :leaser
    end
  end

  form do |f|
    f.inputs t("forms.chapters.main") do
      f.input :number
      f.input :space
      unless params[:level]
        f.input :building, as: :select, collection: Building.all
      end
      f.input :level
      f.actions
    end
  end

  index do
    column :number do |room|
      link_to room.number, admin_room_path(room)
    end
    column :contract_number do |room|
      link_to room.contract.number, admin_contract_path(room.contract)
    end
    column :space do |room|
      space_with_metrics room.space
    end
    column :leaser do |room|
      link_to room.leaser.name, admin_leaser_path(room.leaser)
    end
    column :building do |room|
      room.level.building.name
    end
    column :income do |room|
      number_to_currency room.contract.income
    end
  end
end