class Task < ApplicationRecord
  acts_as_tenant :account

  enum :status, { pending: 0, in_progress: 1, completed: 2, cancelled: 3 }
  enum :priority, { low: 0, medium: 1, high: 2, urgent: 3 }

  belongs_to :account
  belongs_to :event
  belongs_to :assigned_to, class_name: "User", optional: true
  belongs_to :created_by, class_name: "User", optional: true

  validates :title, presence: true, length: { maximum: 200 }

  scope :overdue, -> { where("due_date < ? AND status NOT IN (?)", Date.current, [statuses[:completed], statuses[:cancelled]]) }
  scope :due_soon, -> { where(due_date: Date.current..3.days.from_now).where.not(status: [:completed, :cancelled]) }
  scope :by_priority, -> { order(priority: :desc, due_date: :asc) }
  scope :ordered, -> { order(position: :asc, created_at: :asc) }
  scope :for_user, ->(user) { where(assigned_to: user) }

  before_create :set_default_position

  private

  def set_default_position
    self.position ||= (event.tasks.maximum(:position) || 0) + 1
  end
end
