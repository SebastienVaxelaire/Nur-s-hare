module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      reject_unauthorized_connection unless self.current_user
    end

    private

    def find_verified_user
      User.find_by(id: cookies.encrypted[:user_id])
    end
  end
end
