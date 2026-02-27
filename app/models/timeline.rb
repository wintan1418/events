class Timeline < ApplicationRecord
  acts_as_tenant :account

  belongs_to :account
  belongs_to :event

  validates :start_time, presence: true
  validates :title, presence: true, length: { maximum: 200 }

  scope :chronological, -> { order(start_time: :asc) }
  scope :ordered, -> { order(position: :asc, start_time: :asc) }

  before_create :set_default_position

  private

  def set_default_position
    self.position ||= (event.timelines.maximum(:position) || 0) + 1
  end
end
