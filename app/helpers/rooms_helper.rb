module RoomsHelper
  def allow_room_access(room)
    room = room.id if room.is_a? Room
    session['devise.accessible_rooms'] ||= []
    session['devise.accessible_rooms'] << room
  end

  def allowed_rooms
    session['devise.accessible_rooms'] || []
  end

  def can_access_room(room)
    allowed_rooms.include? room.id
  end
end
