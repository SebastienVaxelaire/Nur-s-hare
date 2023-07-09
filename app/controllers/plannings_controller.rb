class PlanningsController < ApplicationController
  before_action :authenticate_user!

  def new
    @planning = Planning.new
    @group = Group.find(params[:group_id])
    authorize @planning
    @responsible_family = @group.family
    @families_groups_accepted = FamiliesGroup.where(group: @group, confirmation: "accepted")
    @all_families = [@responsible_family]
    @families_groups_accepted.each do |family_group|
      @all_families << family_group.family
    end
    @all_families_names = @all_families.map do |family|
      family.name
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @planning = Planning.new(planning_params)
    @planning.group_id = params[:group_id]
    authorize @planning
    if @planning.save
      redirect_to group_path(@group)
    else
      @responsible_family = @group.family
      @families_groups_accepted = FamiliesGroup.where(group: @group, confirmation: "accepted")
      @all_families = [@responsible_family]
      @families_groups_accepted.each do |family_group|
        @all_families << family_group.family
      end
      @all_families_names = @all_families.map do |family|
        family.name
      end
      render :new, status: :unprocessable_entity
    end
  end

  private

  def planning_params
    params.require(:planning).permit(:name, :start_time, :end_time, :event)
  end
end
