class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :family

  def sender?(a_user)
    family.id == a_user.id
  end
end
