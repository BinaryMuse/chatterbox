$(function(){
  $("#chatinput form").live('ajax:complete.rails', function(event) {
    $(this).children("input[type=text]").val("");
  });

  var room_id   = $(".room_id").data("id");
  var room_name = $(".room_id").data("name");
  var room_hash = $(".room_id").data("hash");

  PrivatePub.subscribe("/rooms/" + room_hash + "/messages", function(data, channel) {
    user    = data.user;
    message = data.message;
    Chatterbox.user_chatted(user, message);
  });

  PrivatePub.subscribe("/rooms/" + room_hash + "/events", function(data, channel) {
    if(data.joined) {
      Chatterbox.user_joined(data.joined);
    }
    if(data.parted) {
      Chatterbox.user_parted(data.parted);
    }
  });

  $("#bigger").click(function() {
    size = $("#chatlog").height();
    size = size + 75;
    $("#chatlog").height(size);
    Chatterbox.scroll_down();
  });
  $("#smaller").click(function() {
    size = $("#chatlog").height();
    size = size - 75;
    $("#chatlog").height(size);
    Chatterbox.scroll_down();
  });

  $.ajax({
      url: "/rooms/" + room_hash + "/joined",
      type: "POST",
      success: function(data, status, xhr) {
        $("#chat_message, #chat_submit").removeAttr('disabled');
        $("#chat_message").focus();
      }
  });
});
