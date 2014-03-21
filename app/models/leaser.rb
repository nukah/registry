# == Schema Information
#
# Table name: leasers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  contacts   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

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

  def self.fields
    %w(name contacts)
  end
end
