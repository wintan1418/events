class EventVendorPolicy < ApplicationPolicy
  def index?
    admin_or_planner?
  end

  def show?
    admin_or_planner? || vendor_owns?
  end

  def create?
    admin_or_planner?
  end

  def update?
    admin_or_planner? || vendor_owns?
  end

  def destroy?
    admin_or_planner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  private

  def vendor_owns?
    vendor? && record.vendor&.user_id == user.id
  end
end
