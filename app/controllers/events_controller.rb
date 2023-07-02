class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    authorize @event
    duration = @event.end.to_time - @event.start.to_time
    @duration_hours = (duration / 3600).to_i
    @families = @event.families
    @already_register = EventsFamily.find_by(family_id: current_user.family).present?
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(params_event)
    authorize @event

    if @event.save
      EventsFamily.create(family_id: current_user.family.id, event_id: @event)
      redirect_to @event, notice: "L'événement a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event

    if @event.update(params_event)
      redirect_to @event, notice: "L'événement a été mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    authorize @event
    @event.destroy

    redirect_to events_url, notice: "L'événement a été supprimé avec succès."
  end

  def register
    @event = Event.find(params[:id])
    authorize @event
    EventsFamily.create!(event_id: @event.id, family_id: current_user.family.id)
    redirect_to group_event_path(@event.group, @event), notice: "Vous êtes inscrit à l'événement."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def params_event
    params.require(:event).permit(:name, :group_id, :start, :end, :description)
  end
end
