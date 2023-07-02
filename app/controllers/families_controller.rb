class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update]

  def show
    @children = Child.where(family: @family)
    @groups_created_by_this_family = Group.where(family_id: @family.id)
    @other_groups = FamiliesGroup.where(family_id: @family.id)
    @families_groups = @groups_created_by_this_family + @other_groups
    @total_groups = @families_groups.count
    # @families_groups = FamiliesGroup.where(family_id: @family.id, confirmation: "accepted")
    # @families_groups_pending = FamiliesGroup.where(family_id: @family.id, confirmation: "pending")
    # @groups_pending = []
    # @families_groups_pending.each do |family_group|
    #   @groups_pending << Group.find(family_group.group_id)
    # end
  end

  def edit
  end

  def update
    if @family.update(params_family)
      redirect_to family_path(@family), notice: 'Votre famille a bien été mise à jour !'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_family
    @family = Family.find(params[:id])
    authorize @family
  end

  def params_family
    params.require(:family).permit(:name, :husband_first_name, :wife_first_name, :address, :phone_number, :description, :key_points, photos: [])
  end

end
