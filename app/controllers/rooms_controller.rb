class RoomsController < ApplicationController
  include RoomsHelper
  before_filter :authenticate_user!, :except => [:index]

  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      allow_room_access(@room)
      redirect_to room_path(@room)
    else
      flash[:alert] = "Your room could not be created."
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    unless @room.password.blank? || can_access_room(@room)
      render 'rooms/locked'
    end
  end

  def unlock
    @room = Room.find(params[:id])
    if @room.has_password? params[:key][:password]
      allow_room_access(@room)
      redirect_to room_path(@room)
    else
      flash[:alert] = "That password was not correct."
      render 'rooms/locked'
    end
  end

  def chat
    @room = Room.find(params[:id])
    unless @room.password.blank? || can_access_room(@room)
      respond_to do |format|
        format.js { render 'rooms/locked' }
      end
    else
      @chat = params[:chat]
      @chat[:user] = current_user.username || current_user.email
      respond_to do |format|
        format.js
      end
    end
  end

end
