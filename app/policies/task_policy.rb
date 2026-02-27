class TaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin_or_planner? || assigned_to_user?
  end

  def create?
    admin_or_planner?
  end

  def update?
    admin_or_planner? || assigned_to_user?
  end

  def destroy?
    admin_or_planner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.planner?
        scope.all
      else
        scope.where(assigned_to: user)
      end
    end
  end

  private

  def assigned_to_user?
    record.assigned_to_id == user.id
  end
end
