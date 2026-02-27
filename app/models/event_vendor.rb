class EventVendor < ApplicationRecord
  acts_as_tenant :account

  enum :status, { pending: 0, contracted: 1, confirmed: 2, completed: 3, cancelled: 4 }

  belongs_to :account
  belongs_to :event
  belongs_to :vendor
  has_many :line_items, dependent: :nullify

  has_many_attached :contracts

  validates :vendor_id, uniqueness: { scope: :event_id, message: "is already assigned to this event" }
  validates :contracted_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :paid_amount, numericality: { greater_than_or_equal_to: 0 }

  scope :outstanding, -> { where("paid_amount < contracted_amount") }
  scope :fully_paid, -> { where("paid_amount >= contracted_amount") }

  def balance_due
    contracted_amount.to_d - paid_amount.to_d
  end

  def payment_percentage
    return 0 if contracted_amount.to_d.zero?
    ((paid_amount.to_d / contracted_amount.to_d) * 100).round(1)
  end
end
