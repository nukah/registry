ActiveAdmin.register Room do
  menu priority: 14
  controller do
    def permitted_params
      params.permit(:room => [:number, :space])
    end
  end
end
