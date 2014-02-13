class Leaser < ActiveRecord::Base
  has_many :contracts
  has_many :rooms, through: :contracts

  monetize :income, :as => "leaser_income"

  # Суммарный доход от арендатора
  def income
    self.contracts.to_a.sum(&:income)
  end
end
