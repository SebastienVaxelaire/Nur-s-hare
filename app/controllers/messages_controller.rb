class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    authorize @chatroom
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.family = current_user.family
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.family.id
      )
      @group = @chatroom.group
      @family_group = FamiliesGroup.find_by(family_id: current_user.family.id, group_id: @group.id)
      @family_group.update(last_read_at: Time.current) if @family_group
      @group.update(last_read_at: Time.current) if @group.family == current_user.family
      head :ok
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :family_id)
  end
end
