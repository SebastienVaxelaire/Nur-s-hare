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
      NotificationsChannel.broadcast_to(
        @group.family.user,
        message: "La famille #{@family.name} souhaite rejoindre votre groupe ",
        link: group_path(@group.id),
        groupname: @group.name
      )
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
    NotificationsChannel.broadcast_to(
      @family_group.family.user,
      message: "Vous avez été accepté dans le groupe ",
      link: group_path(@group.id),
      groupname: @group.name
    )
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

  def destroy
    @group = Group.find(params[:id])
    @family_group = FamiliesGroup.find_by(group_id: @group.id, family_id: current_user.family)
    authorize @family_group
    @family_group.destroy
    redirect_to groups_path
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
