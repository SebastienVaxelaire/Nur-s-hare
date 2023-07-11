class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_group, only: [:new, :create, :update, :destroy]
  def index
    @events = Event.all
  end

  def show
    authorize @event
    duration = @event.end.to_time - @event.start.to_time
    @duration_hours = (duration / 3600).to_i
    @duration_minutes = ((duration - (@duration_hours * 3600)) / 60).to_i
    @families = @event.families
    @already_register = EventsFamily.find_by(family_id: current_user.family, event_id: @event).present?
    @event_family = EventsFamily.find_by(event_id: @event, family_id: current_user.family)
  end

  def new
    # raise
    @event = Event.new
    authorize @event
  end

  def create
    # raise
    @event = Event.new(params_event)
    authorize @event
    @event.group = @group
    if @event.save
      EventsFamily.create(family_id: current_user.family.id, event_id: @event.id)
      @planning = Planning.new(name: @event.name, start_time: @event.start, end_time: @event.end, group_id: @event.group_id, event: true)
      authorize @planning
      @planning.save
      redirect_to group_event_path(@group, @event), notice: "L'événement #{@event.name} a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    @event.group = @group
    if @event.update(params_event)
      redirect_to group_event_path(@group, @event), notice: "L'événement #{@event.name} a été mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to group_path(@group), notice: "L'événement #{@event.name} a été supprimé avec succès."
  end

  def register
    @event = Event.find(params[:id])
    authorize @event
    EventsFamily.create!(event_id: @event.id, family_id: current_user.family.id)
    redirect_to group_event_path(@event.group, @event), notice: "Vous êtes inscrit à l'événement #{@event.name} !"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
    authorize @group
  end

  def params_event
    params.require(:event).permit(:name, :start, :end, :description)
  end

  def planning_params
    params.require(:planning).permit(:name, :start_time, :end_time, :event)
  end
end
