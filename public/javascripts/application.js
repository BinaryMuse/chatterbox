Chatterbox = {
  user_joined: function(user) {
    Chatterbox.append_text("<b>" + user + " has joined the room.</b>");
  },

  user_parted: function(user) {
    Chatterbox.append_text("<b>" + user + " has left the room.</b>");
  },

  user_chatted: function(user, message) {
    Chatterbox.append_text("<b>" + user + "</b>: " + message);
  },

  append_text: function(text) {
    el = $("<p>").html(text);
    $("#chatlog").append(el);
    $("#chatlog").attr({ scrollTop: $("#chatlog").attr("scrollHeight") });
  }
};