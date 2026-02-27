class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin? || planner_assigned? || client_owns? || vendor_assigned?
  end

  def create?
    admin_or_planner?
  end

  def update?
    admin? || planner_assigned?
  end

  def destroy?
    admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role
      when "admin"
        scope.all
      when "planner"
        scope.for_planner(user)
      when "client"
        scope.for_client(user)
      when "vendor"
        scope.joins(:event_vendors).joins(:vendors).where(vendors: { user_id: user.id })
      else
        scope.none
      end
    end
  end

  private

  def planner_assigned?
    planner? && record.planner_id == user.id
  end

  def client_owns?
    client? && record.client_id == user.id
  end

  def vendor_assigned?
    vendor? && record.vendors.exists?(user_id: user.id)
  end
end
