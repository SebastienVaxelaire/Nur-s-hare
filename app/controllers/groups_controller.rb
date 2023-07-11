class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = policy_scope(Group)
    @family = current_user.family
    @markers = @groups.geocoded.map do |group|
      {
        lat: group.latitude,
        lng: group.longitude,
        rad: group.place_radius,
        id: group.id,
        info_window_html: render_to_string(partial: "info_window", locals: {group: group}),
        marker_html: render_to_string(partial: "marker")
      }
    end
    @family_marker = [{ lat: @family.latitude,
                        lng: @family.longitude,
                        info_window_html: render_to_string(partial: "info_window_family"),
                        marker_html: render_to_string(partial: "marker_family")}]
    @all_markers = @markers + @family_marker
  end

  def new
    @family = current_user.family
    @group = Group.new
    authorize @group
  end

  def show
    @families_groups = FamiliesGroup.where(group: @group, confirmation: "pending")
    @responsible_family = @group.family
    @families_groups_accepted = FamiliesGroup.where(group: @group, confirmation: "accepted")
    @all_families = [@responsible_family]
    @families_groups_accepted.each do |family_group|
      @all_families << family_group.family
    end
    @invited_family = FamiliesGroup.find_by(group_id: @group, family_id: current_user.family, confirmation: "pending")
    @accepted_family = FamiliesGroup.find_by(group_id: @group, family_id: current_user.family, confirmation: "accepted")
    @marker = [{ lat: @group.latitude,
                 lng: @group.longitude,
                 info_window_html: render_to_string(partial: "info_window", locals: {group: @group}),
                 marker_html: render_to_string(partial: "marker")}]
    # Calendar
    start_date = params.fetch(:start_date, Date.today).to_date
    @plannings = Planning.where(group_id: params[:id], start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @family_group = FamiliesGroup.find_by(group_id: @group, family_id: current_user.family)
    @chatroom = @group.chatroom
    if @accepted_family
      @unread_messages_count = @chatroom.messages.where("created_at > ?", @accepted_family.last_read_at).count
    elsif @responsible_family == current_user.family
      @unread_messages_count = @chatroom.messages.where("created_at > ?", @group.last_read_at).count
    else
      @unread_messages_count = 0
    end
    @events = Event.where(group_id: @group)
    @events_to_come = @events.where('events."end" > ?', Time.now)
    @past_events = @events.where('events."end" < ?', Time.now)
    # chatroom
    @chatroom = Chatroom.find_by(group_id: @group)
    authorize @chatroom
    @group = @chatroom.group
    @family_group = FamiliesGroup.find_by(family_id: current_user.family.id, group_id: @group.id)
    @family_group.update(last_read_at: Time.current) if @family_group
    @group.update(last_read_at: Time.current) if @group.family == current_user.family
    @message = Message.new
  end

  def create
    @family = Family.find(params[:family_id])
    @group = Group.new(group_params)
    authorize @group
    @group.family = @family
    if @group.save
      redirect_to group_path(@group), notice: 'Groupe créé avec succès !'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @family = Family.find(params[:family_id])
  end

  def update
    @family = Family.find(params[:family_id])
    # raise
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'Groupe mis à jour !'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @family = current_user.family
    @group.destroy
    redirect_to groups_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def group_params
    params.require(:group).permit(:name, :description, :banner_photo, :place_address, :place_radius)
  end
end
