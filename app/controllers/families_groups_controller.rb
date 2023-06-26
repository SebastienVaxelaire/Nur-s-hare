class FamiliesGroupsController < ApplicationController
  def new
    create
  end

  def create
    @group = Group.find(params[:group_id])
    @family = current_user.family
    # raise
    if check(@group, @family)
      @families_group = FamiliesGroup.new(family_id: @family.id, group_id: @group.id, confirmation: "pending")
      @families_group.save
      # @families_group.family = @family
      # @families_group.group = @group
      redirect_to group_path(@group), notice: 'Demande effectuée !'
    else
      redirect_to group_path(@group), notice: 'Vous avez déjà demandé à rejoindre ce groupe'
    end
  end

  def accept
    # raise
    @family_group = FamiliesGroup.find(params[:id])
    group_id = @family_group.group_id
    @group = Group.find(group_id)
    @family_group.update(confirmation: 'accepted')
    redirect_to group_path(@group), notice: 'La demande a été acceptée !'
  end

  def refuse
    # raise
    @family_group = FamiliesGroup.find(params[:id])
    group_id = @family_group.group_id
    @group = Group.find(group_id)
    @family_group.update(confirmation: 'refused')
    redirect_to group_path(@group), notice: 'La demande a été refusée'
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
