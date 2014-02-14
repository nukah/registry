ActiveAdmin.register Room do
  controller do
    def permitted_params
      params.permit(:room => [:number, :space])
    end
  end
end
