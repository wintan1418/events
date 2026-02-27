class Vendor < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_tenant :account

  enum :category, {
    catering: 0, photography: 1, videography: 2, florist: 3,
    dj_music: 4, venue: 5, decor: 6, lighting: 7,
    transportation: 8, cake: 9, stationery: 10,
    entertainment: 11, rentals: 12, other: 13
  }

  belongs_to :account
  belongs_to :user, optional: true
  has_many :event_vendors, dependent: :destroy
  has_many :events, through: :event_vendors

  has_one_attached :logo
  has_many_attached :portfolio_images

  validates :name, presence: true, length: { maximum: 150 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  scope :active, -> { where(active: true) }
  scope :by_category, ->(cat) { where(category: cat) }
end
