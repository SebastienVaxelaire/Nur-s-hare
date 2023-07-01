class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @group = @chatroom.group
    @family_group = FamiliesGroup.find_by(family_id: current_user.family.id, group_id: @group.id)
    @family_group.update(last_read_at: Time.current) if @family_group
    @message = Message.new
  end
end
