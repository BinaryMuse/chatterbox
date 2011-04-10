Chatterbox
==========

Chatterbox is a small multi-room chat website built using Ruby on Rails and [Faye][faye] (using the [PrivatePub gem][privatepub] by Ryan Bates). This was just thrown togeter in the past few hours, but all of the "excitement" is in the following files:

 * [`app/controllers/rooms_controller.rb`](https://github.com/BinaryMuse/chatterbox/blob/master/app/controllers/rooms_controller.rb)
 * [`public/javascripts/chatterbox.js`](https://github.com/BinaryMuse/chatterbox/blob/master/public/javascripts/chatterbox.js)
 * [`public/javascripts/room.js`](https://github.com/BinaryMuse/chatterbox/blob/master/public/javascripts/room.js)

Expect some improvements as time permits. Specifically:

 * A list of users currently in a room, along with active/idle status
 * Rooms get deleted after they are empty for a certain amount of time
 * Able to change room settings after creation
 * Third-party auth that doesn't crash MRI
 * Maybe even an API!?

  [faye]: http://faye.jcoglan.com/
  [privatepub]: http://github.com/ryanb/private_pub