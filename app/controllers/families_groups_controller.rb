class FamiliesGroupsController < ApplicationController
  def create
    # raise
    @group = Group.find(params[:group_id])
    @family = current_user.family
    # raise
    @families_group = FamiliesGroup.new(family: @family, group: @group, confirmation: "pending")
    authorize @families_group
    if check(@group, @family)
      @families_group.save
      redirect_to group_path(@group), notice: 'Demande effectuée !'
    else
      redirect_to group_path(@group), notice: 'Vous avez déjà demandé à rejoindre ce groupe'
    end
  end

  def accept
    # raise
    @family_group = FamiliesGroup.find(params[:id])
    authorize @family_group
    group_id = @family_group.group_id
    @group = Group.find(group_id)
    @family_group.update(confirmation: 'accepted')
    redirect_to group_path(@group), notice: 'La demande a été acceptée !'
  end

  def refuse
    # raise
    @family_group = FamiliesGroup.find(params[:id])
    authorize @family_group
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
