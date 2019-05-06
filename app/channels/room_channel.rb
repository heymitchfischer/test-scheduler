class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from("room_channel_#{params[:room]}")
    current_user.update(online: true)
    ActionCable.server.broadcast("room_channel_#{params[:room]}", {username: current_user.user_name, update: "subscribe"})
  end

  def unsubscribed
    ActionCable.server.broadcast("room_channel_#{params[:room]}", {username: current_user.user_name, update: "unsubscribe"})
    current_user.update(online: false)
  end

  # def receive(data)
  #   if data["update"] == "subscribed"
  #     broadcast_to(user_name)
  #   end
  # end
end
