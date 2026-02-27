class Guest < ApplicationRecord
  acts_as_tenant :account

  enum :rsvp_status, { pending: 0, confirmed: 1, declined: 2, tentative: 3 }

  belongs_to :account
  belongs_to :event

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :party_size, numericality: { greater_than: 0, only_integer: true }
  validates :table_number, numericality: { greater_than: 0, only_integer: true }, allow_nil: true

  scope :attending, -> { where(rsvp_status: [:confirmed, :tentative]) }
  scope :alphabetical, -> { order(last_name: :asc, first_name: :asc) }
  scope :by_table, -> { order(table_number: :asc) }
  scope :without_table, -> { where(table_number: nil) }
  scope :with_dietary_needs, -> { where.not(dietary_notes: [nil, ""]) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def total_attending
    confirmed? ? party_size : 0
  end
end
