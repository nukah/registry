ActiveAdmin.register Purpose do

  config.filters = false
  controller do
    def permitted_params
      params.permit(:purpose => [:name])
    end
  end

end
