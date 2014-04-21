ActiveAdmin.register Building do
  scope :all, :default => true
  menu priority: 12, parent: 'rent', label: I18n.t('page_titles.building')
  action_item only: :show do
    link_to(t('active_admin.add_model', model: t('activerecord.models.level', count: 1)), new_admin_level_path(building: resource.id))
  end

  controller do
    def permitted_params
      params.permit(:building => [:territory_id, :name, :address, :certificate, :building_passport])
    end

    before_action :predefine_territory, only: [:new]

    def predefine_territory
      t = params[:territory]
      if t && Territory.exists?(t)
        @building = Building.new()
        @building.territory = Territory.find(t)
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

  index title: I18n.t('page_titles.buildings') do
    column :name do |building|
      link_to building.name, admin_building_path(building)
    end
    column :address
    column :certificate
    column t('headers.territory', count: 1) do |building|
      building.territory.name if building.territory
    end
    column t('headers.entity', count: 1) do |building|
      building.territory.entity.name if building.territory
    end
    column :building_income, sortable: false do |building|
      number_to_currency building.building_income
    end
    column :free_space, sortable: false do |building|
      space_with_metrics building.free_space
    end
    column t('headers.level', count: 5) do |building|
      building.levels.size
    end
    column do |building|
      download_links :building_passport, building
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs t("formtastic.titles.main") do
      f.input :territory, as: :select
      f.input :name
      f.input :address
    end

    f.inputs t("formtastic.titles.additional") do
      f.input :certificate, as: :number
      f.input :building_passport, as: :file, hint: f.template.image_tag(f.object.building_passport.url(:small), class: 'attachment_image')
    end

    f.actions
  end
end
