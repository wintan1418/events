class User < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  acts_as_tenant :account

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable

  enum :role, { planner: 0, client: 1, vendor: 2, admin: 3 }

  belongs_to :account
  has_many :planned_events, class_name: "Event", foreign_key: :planner_id, dependent: :nullify
  has_many :client_events, class_name: "Event", foreign_key: :client_id, dependent: :nullify
  has_many :assigned_tasks, class_name: "Task", foreign_key: :assigned_to_id, dependent: :nullify
  has_many :created_tasks, class_name: "Task", foreign_key: :created_by_id, dependent: :nullify
  has_one :vendor_profile, class_name: "Vendor", dependent: :nullify

  has_one_attached :avatar

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :role, presence: true

  scope :active, -> { where(active: true) }
  scope :admins, -> { where(role: :admin) }
  scope :planners, -> { where(role: :planner) }
  scope :clients, -> { where(role: :client) }
  scope :vendors_role, -> { where(role: :vendor) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end

  # Override Devise to search across all tenants during authentication
  def self.find_for_authentication(conditions)
    ActsAsTenant.without_tenant do
      find_first_by_auth_conditions(conditions)
    end
  end

  # Override for password reset token lookups across tenants
  def self.send_reset_password_instructions(attributes = {})
    ActsAsTenant.without_tenant do
      super
    end
  end

  # Override for confirmation token lookups across tenants
  def self.send_confirmation_instructions(attributes = {})
    ActsAsTenant.without_tenant do
      super
    end
  end

  # Override for unlock token lookups across tenants
  def self.send_unlock_instructions(attributes = {})
    ActsAsTenant.without_tenant do
      super
    end
  end
end
