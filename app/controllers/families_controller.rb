class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update]

  def show
    @children = Child.where(family: @family)
    @total_groups = Group.where(family_id: @family.id).count + FamiliesGroup.where(family_id: @family.id).count
    # raise
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
      redirect_to family_path(@family)
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
