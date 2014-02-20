ActiveAdmin.register Room do
  menu priority: 14
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

  index do
    column :number
    column :contract_number do |room|
      room.contract.number
    end
    column :space do |room|
      space_with_metrics room.space
    end
    column :leaser do |room|
      link_to room.leaser.name, admin_leaser_path(room.leaser)
    end
    column :income do |room|
      number_to_currency room.contract.income
    end
  end
end
