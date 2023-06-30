class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.where(group_id: params[:group_id])
  end
end
