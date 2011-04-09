$(function(){
  $("#chatinput form").live('ajax:complete.rails', function(event) {
    $(this).children("input[type=text]").val("");
  });

  var room_id = $(".room_id").data("id");

  PrivatePub.subscribe("/rooms/" + room_id + "/messages", function(data, channel) {
    user    = data.user;
    message = data.message;
    Chatterbox.user_chatted(user, message);
  });

  PrivatePub.subscribe("/rooms/" + room_id + "/events", function(data, channel) {
    if(data.joined) {
      Chatterbox.user_joined(data.joined);
    }
    if(data.parted) {
      Chatterbox.user_parted(data.parted);
    }
  });

  $("#chat_message, #chat_submit").removeAttr('disabled');
  $("#chat_message").focus();
});
