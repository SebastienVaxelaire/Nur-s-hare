class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @group = Group.find_by(id: params[:group_id])
    @message = Message.new
  end
end
