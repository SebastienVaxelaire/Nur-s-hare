class FamiliesGroupPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    user.family != record.group.family
  end

  def accept?
    user.family == record.group.family
  end

  def refuse?
    accept?
  end

  def destroy?
    user.family == record.family
  end
end
