class LineItem < ApplicationRecord
  acts_as_tenant :account

  belongs_to :account
  belongs_to :event
  belongs_to :event_vendor, optional: true

  validates :category, presence: true
  validates :description, presence: true
  validates :estimated_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :actual_cost, numericality: { greater_than_or_equal_to: 0 }

  scope :paid, -> { where(paid: true) }
  scope :unpaid, -> { where(paid: false) }
  scope :by_category, ->(cat) { where(category: cat) }
  scope :over_budget, -> { where("actual_cost > estimated_cost") }

  def variance
    actual_cost.to_d - estimated_cost.to_d
  end

  def over_budget?
    actual_cost.to_d > estimated_cost.to_d
  end
end
