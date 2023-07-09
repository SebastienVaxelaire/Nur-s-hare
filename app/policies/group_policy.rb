class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.near(user.family.address, 10)
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    user.family == record.family
  end

  def update?
    user.family == record.family
  end
end
