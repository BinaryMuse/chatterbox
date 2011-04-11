Chatterbox = {
  focused: true,
  notified: false,
  interval: '',

  user_joined: function(user) {
    Chatterbox.append_text("<b>" + user + " has joined the room.</b>");
  },

  user_parted: function(user) {
    Chatterbox.append_text("<b>" + user + " has left the room.</b>");
  },

  user_chatted: function(user, message) {
    Chatterbox.append_text("<b>" + user + "</b>: " + message);
  },

  set_focused: function(focused) {
    Chatterbox.focused = focused;
    if(Chatterbox.focused) {
      Chatterbox.stop_notifying();
    }
  },

  start_notifying: function() {
    Chatterbox.interval = setInterval(Chatterbox.flash, 1000);
  },

  stop_notifying: function() {
    clearInterval(Chatterbox.interval);
    document.title = "Chatterbox";
  },

  flash: function() {
    if(Chatterbox.notified) {
      document.title = "Chatterbox";
    } else {
      document.title = "(*) Chatterbox";
    }
    Chatterbox.notified = !Chatterbox.notified;
  },

  append_text: function(text) {
    el = $("<p>").html(text);
    $("#chatlog").append(el);
    Chatterbox.scroll_down();
    if(!Chatterbox.focused && !Chatterbox.notifying) {
      Chatterbox.start_notifying();
    }
  },

  scroll_down: function() {
    $("#chatlog").attr({ scrollTop: $("#chatlog").attr("scrollHeight") });
  }
};
