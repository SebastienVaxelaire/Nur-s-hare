class EventsFamiliesController < ApplicationController

  def destroy
    @event = Event.find(params[:event_id])
    @group = @event.group
    @event_family = EventsFamily.find_by(event_id: @event.id, family_id: current_user.family)
    authorize @event_family
    @event_family.destroy
    redirect_to group_path(@group)
  end

end
