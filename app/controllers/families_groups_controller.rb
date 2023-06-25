class FamiliesGroupsController < ApplicationController
  def new
    create
  end

  def create
    @group = Group.find(params[:group_id])
    @family = current_user.family
    # raise
    if check(@group, @family)
      # raise
      @families_group = FamiliesGroup.new(family_id: @family.id, group_id: @group.id, confirmation: "pending")
      @families_group.save
      # @families_group.family = @family
      # @families_group.group = @group
    end
    redirect_to group_path(@group), notice: 'Vous ne pouvez pas demander de rejoindre ce group'
  end

  private

  def check(group, family)
    @families_groups = FamiliesGroup.where(group_id: group.id, family_id: family.id)
    # raise
    return @families_groups.size == 0
  end

  # def families_group_params
  #   params.require(:families_group).permit(:confirmation)
  # end
end
