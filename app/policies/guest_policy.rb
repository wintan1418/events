class GuestPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin_or_planner? || client?
  end

  def create?
    admin_or_planner? || client?
  end

  def update?
    admin_or_planner? || client?
  end

  def destroy?
    admin_or_planner? || client?
  end

  def export?
    admin_or_planner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
