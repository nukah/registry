class Leaser < ActiveRecord::Base
  has_many :contracts
  has_many :rooms, through: :contracts

  monetize :income, :as => "leaser_income"

  searchable do
    text :name
    text :contacts
  end

  # Суммарный доход от арендатора
  def income
    self.contracts.to_a.sum(&:income)
  end

  def self.fieldset
    ['name', 'contacts']
  end
end
