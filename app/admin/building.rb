ActiveAdmin.register Building do
  scope :all, :default => true
  menu priority: 12
  config.filters = true

  controller do
    def permitted_params
      params.permit(:territory => [:name, :address, :cad, :space, :certificate, :building_passport])
    end

    before_action :predefine_territory, only: [:new]

    def predefine_territory
      t = params[:territory]
      if t && Territory.exists?(t)
        @building = Building.new()
        @building.territory = Territory.find(t)
      else
        @building = Building.new()
      end
    end
  end

  member_action :download_building_passport, method: :get do
    building = Building.find(params[:id])
    send_file building.building_passport.path,
              type: building.building_passport_content_type,
              filename: building.building_passport_download_name
  end

  show do |building|
    render "levels", levels: building.levels, building: building
  end

  filter :territory, as: :select

  index do
    column :name do |building|
      link_to building.name, edit_admin_building_path(building)
    end
    column :address
    column :certificate
    column :building_income, sortable: false do |building|
      number_to_currency building.building_income
    end
    column :free_space, sortable: false do |building|
      space_with_metrics building.free_space
    end
    column t('floors') do |building|
      link_to building.levels.size, admin_building_path(building)
    end
    column t(:building_passport) do |building|
      link_to(t(:building_passport), download_building_passport_admin_building_url(building), disabled: !building.building_passport.exists?)
    end
  end

  form do |f|
    f.inputs t("forms.chapters.main") do
      f.input :territory, as: :select
      f.input :name
      f.input :address
    end

    f.inputs t("forms.chapters.additional") do
      f.input :certificate, as: :number
      f.input :building_passport, as: :file
    end

    f.actions
  end
end
