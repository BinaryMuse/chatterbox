Chatterbox = {
  focused: true,
  notifying: false,
  alt_title: false,
  interval: '',
  notification: '',

  user_joined: function(user) {
    Chatterbox.append_text("<b>" + user + " has joined the room.</b>");
  },

  user_parted: function(user) {
    Chatterbox.append_text("<b>" + user + " has left the room.</b>");
  },

  user_chatted: function(user, message) {
    Chatterbox.append_text("<b>" + user + "</b>: " + message);
  },

  set_focused: function(focus) {
    console.log("Focused: " + focus);
    Chatterbox.focused = focus;
    if(Chatterbox.focused) {
      Chatterbox.stop_notifying();
    }
  },

  notify: function() {
    if(!Chatterbox.focused && !Chatterbox.notifying) {
      console.log("notify(): starting the notifications");
      Chatterbox.start_notifying();
    } else {
      console.log("notify(): incrementing the notifications");
      Chatterbox.notification++;
    }
  },

  start_notifying: function() {
    Chatterbox.notifying = true;
    Chatterbox.notification = 1;
    Chatterbox.interval = window.setTimeout(Chatterbox.flash, 1000);
  },

  stop_notifying: function() {
    console.log("stop_notifying(): stopping the notifications");
    window.clearInterval(Chatterbox.interval);
    document.title = "Chatterbox";
    Chatterbox.notification = "";
    Chatterbox.notifying = false;
  },

  flash: function() {
    if(Chatterbox.alt_title) {
      document.title = "Chatterbox";
    } else {
      document.title = "(" + Chatterbox.notification + ") Chatterbox";
    }
    Chatterbox.alt_title = !Chatterbox.alt_title;

    if(!Chatterbox.focused) {
      console.log("flash(): not focused, resetting timeout");
      window.setTimeout(Chatterbox.flash, 1000);
    } else {
      document.title = "Chatterbox";
    }
  },

  append_text: function(text) {
    el = $("<p>").html(text);
    $("#chatlog").append(el);
    Chatterbox.scroll_down();
    Chatterbox.notify();
  },

  scroll_down: function() {
    $("#chatlog").attr({ scrollTop: $("#chatlog").attr("scrollHeight") });
  }
};
