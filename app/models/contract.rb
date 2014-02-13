class Contract < ActiveRecord::Base
  belongs_to :room
  belongs_to :leaser
  monetize :income, :as => "contract_income"

  private
  # Доход от аренды помещения
  def income
    self.room.space * self.rate
  end
end
