module Reports
  class Base
    include Datagrid
    scope do
      Composer.new.query
    end

    filter(:territory_name, :string)
    filter(:building_name, :string)
    filter(:leaser_name, :string)

    column(:territory_name)
    column(:building_name)
    column(:level_number)
    column(:leaser_name)
    column(:contract_number)
    column(:contract_sign_date) do |attr|
      if attr.contract_sign_date
        attr.contract_sign_date.to_time.strftime("%d-%m-%Y")
      end
    end
    column(:contract_duration) do |attr|
      (attr.contract_sign_date.to_time + attr.contract_duration.months).strftime("%d-%m-%Y") if (attr.contract_sign_date && attr.contract_duration)
    end
    column(:room_space) do |attr|
      attr.room_space
    end
    column(:contract_rate)
    column(:contract_income) do |attr|
      (attr.contract_rate * attr.room_space)/12
    end
    column(:contract_annual_income) do |attr|
      attr.contract_rate * attr.room_space
    end
  end
end