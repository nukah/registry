ActiveAdmin.register AdminUser do
  menu priority: 5, parent: 'admin'
  permit_params :email, :password, :password_confirmation, :role

  controller do
    def update
      if params[:admin_user][:password].blank?
        params[:admin_user].delete("password")
        params[:admin_user].delete("password_confirmation")
      end
      super
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do |user|
    attributes_table do
      row :email
      row :role
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation

      f.input :role, collection: Hash[AdminUser::ROLES.map { |role| [t("roles.#{role}"), role]}]
    end
    f.actions
  end

end
