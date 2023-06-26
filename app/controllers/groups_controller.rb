class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @family = current_user.family
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @family = @group.family
    @families_groups = FamiliesGroup.where(group_id: @group.id, confirmation: "pending")
  end

  def create
    @family = Family.find(params[:family_id])
    @group = Group.new(group_params)
    @group.family = @family
    # raise
    if @group.save
      # raise
      redirect_to family_path(@family)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @family = Family.find(params[:family_id])
    @group = Group.find(params[:id])
  end

  def update
    @family = Family.find(params[:family_id])
    @group = Group.find(params[:id])
    # raise
    if @group.update(group_params)
      redirect_to family_path(@family)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @family = current_user.family
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to family_path(@family)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :banner_photo)
  end

  # def families_want_to_join_includes_current_family
  #   @families_want_to_join.each do |f|
  #     f[0].include?(current_user.family)
  #   end
  # end
end
