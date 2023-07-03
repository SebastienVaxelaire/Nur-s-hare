class PlanningsController < ApplicationController
  before_action :authenticate_user!

  def new
    @planning = Planning.new
    @group = Group.find(params[:group_id])
    authorize @planning
  end

  def create
    @group = Group.find(params[:group_id])
    @planning = Planning.new(planning_params)
    @planning.group_id = params[:group_id]
    authorize @planning
    if @planning.save
      redirect_to group_path(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def planning_params
    params.require(:planning).permit(:name, :start_time, :end_time)
  end
end
