class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_tenant :account

  enum :event_type, { wedding: 0, corporate: 1, social: 2, gala: 3, conference: 4, other: 5 }
  enum :status, { draft: 0, planning: 1, confirmed: 2, in_progress: 3, completed: 4, cancelled: 5 }

  belongs_to :account
  belongs_to :planner, class_name: "User", optional: true
  belongs_to :client, class_name: "User", optional: true
  has_many :tasks, dependent: :destroy
  has_many :event_vendors, dependent: :destroy
  has_many :vendors, through: :event_vendors
  has_many :line_items, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :timelines, dependent: :destroy

  has_one_attached :cover_image
  has_many_attached :mood_board_images
  has_many_attached :documents

  validates :title, presence: true, length: { maximum: 200 }
  validates :budget_total, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :estimated_guests, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: true

  scope :upcoming, -> { where("event_date >= ?", Date.current).order(event_date: :asc) }
  scope :past, -> { where("event_date < ?", Date.current).order(event_date: :desc) }
  scope :by_status, ->(status) { where(status: status) }
  scope :for_planner, ->(user) { where(planner: user) }
  scope :for_client, ->(user) { where(client: user) }

  def budget_spent
    line_items.sum(:actual_cost)
  end

  def budget_estimated
    line_items.sum(:estimated_cost)
  end

  def budget_remaining
    budget_total.to_d - budget_spent
  end

  def budget_percentage
    return 0 if budget_total.to_d.zero?
    ((budget_spent / budget_total.to_d) * 100).round(1)
  end

  def guest_count_confirmed
    guests.confirmed.count
  end

  def tasks_completion_percentage
    return 0 if tasks.count.zero?
    ((tasks.completed.count.to_f / tasks.count) * 100).round(1)
  end

  def days_until
    return nil unless event_date
    (event_date - Date.current).to_i
  end
end
