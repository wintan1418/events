class TimelinePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin_or_planner?
  end

  def update?
    admin_or_planner?
  end

  def destroy?
    admin_or_planner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
