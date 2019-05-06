class RoomsController < ApplicationController
  def index
    if params[:room_code] && Room.find_by(code: params[:room_code])
      room = Room.find_by(code: params[:room_code])
      if room.users.find_by(user_name: params[:user_name])
        session[:user_id] = room.users.find_by(user_name: params[:user_name]).id
      else
        user = room.users.create(user_name: params[:user_name])
        session[:user_id] = user.id
      end
      session[:room_code] = params[:room_code]
      flash[:success] = "You joined the room!"
      redirect_to "/rooms/#{room.code}"
    elsif params[:room_code]
      flash[:error] = "There was no room with that code."
      redirect_to "/rooms"
    end
  end

  def show
    @room = Room.find_by(code: params[:room_code])
    session[:room_code] = params[:room_code]

    if current_user && @room.users.find_by(user_name: current_user.user_name)
      current_user.update(online: true)
    else
      flash[:error] = "Select a username to join the room!"
      redirect_to "/rooms"
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(name: params[:room_name], description: params[:room_description])
    if @room.save
      user = @room.users.create(user_name: params[:user_name])
      session[:user_id] = user.id
      session[:room_code] = @room.code
      flash[:success] = "Room was created! You're now hosting."
      redirect_to "/rooms/#{@room.code}"
    else
      render 'new'
    end
  end
end
