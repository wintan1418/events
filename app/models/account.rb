class Account < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum :plan_type, { free: 0, starter: 1, professional: 2, enterprise: 3 }

  has_many :users, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :vendors, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :event_vendors, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :timelines, dependent: :destroy

  has_one_attached :logo

  validates :name, presence: true, length: { maximum: 100 }
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[a-z0-9]([a-z0-9\-]*[a-z0-9])?\z/i, message: "only allows letters, numbers, and hyphens" },
            length: { minimum: 3, maximum: 63 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  scope :active, -> { where(active: true) }
end
