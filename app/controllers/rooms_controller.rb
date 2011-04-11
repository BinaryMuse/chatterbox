class RoomsController < ApplicationController
  include RoomsHelper
  before_filter :authenticate_user!, :except => [:index]
  before_filter :verify_room_permissions, :only => [:show, :chat, :leave, :joined, :parted]

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

  def join
  end

  def search
    @room = Room.find_by_name(params[:room][:name])
    if @room
      redirect_to @room
    else
      redirect_to join_rooms_path, :alert => "Couldn't locate a room with that name."
    end
  end

  def show
  end

  def unlock
    @room = Room.find_by_sha1(params[:id])
    if @room.has_password? params[:key][:password]
      allow_room_access(@room)
      redirect_to room_path(@room)
    else
      flash[:alert] = "That password was not correct."
      render 'locked'
    end
  end

  def chat
    @chat = params[:chat]
    @chat[:user] = current_user.username || current_user.email
    publish_to "/rooms/#{@room.sha1}/messages", @chat
    render :nothing => true
  end

  def joined
    publish_to "/rooms/#{@room.sha1}/events", :joined => (current_user.username || current_user.email)
    render :text => "success"
  end

  def parted
    publish_to "/rooms/#{@room.sha1}/events", :parted => (current_user.username || current_user.email)
    render :nothing => true
  end

  private

    def verify_room_permissions
      @room = Room.find_by_sha1!(params[:id])
      unless @room.password.blank? || can_access_room(@room)
        respond_to do |format|
          format.html { render 'locked' }
          format.js   { render 'locked' }
        end
        return
      end
    end

end
