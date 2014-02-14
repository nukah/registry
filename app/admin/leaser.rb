ActiveAdmin.register Leaser do
  filter :contracts, as: :string
  filter :name, as: :string
  sidebar I18n.t(:details), label: I18n.t(:details), only: [:show, :edit] do
    ul do
      li link_to(t(:contracts), admin_leaser_contracts_path(leaser))
    end
  end
end
