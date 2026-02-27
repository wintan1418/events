class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin? || record.id == user.id
  end

  def create?
    admin?
  end

  def update?
    admin? || record.id == user.id
  end

  def destroy?
    admin? && record.id != user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
