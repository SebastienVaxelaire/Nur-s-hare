class ChildPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    user == record.family.user
  end

  def edit?
    create?
  end

  def update
    user == record.family.user
  end

  def destroy
    user == record.family.user
  end
end
