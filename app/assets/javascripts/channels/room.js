$(document).ready(function() {
  var roomCode = $('[data-channel-subscribe="room"]').data("room-code");
  var $userList = $('.user-list');

  App.roomChannel = App.cable.subscriptions.create(
    {
      channel: "RoomChannel",
      room: roomCode
    },
    {
      received: function(data) {
        if (data.update === "subscribe") {
          if ($(`[data-user-name="${data.username}"]`).length) {
            var $onlineUser = $(`[data-user-name="${data.username}"]`);
            $onlineUser.addClass('online');
          } else {
            var $onlineUser = $(`<li data-user-name="${data.username}" class="online">${data.username}</li>`).hide();
            $userList.append($onlineUser.fadeIn());
          }
        } else if (data.update === "unsubscribe") {
          var $disconnectedUser = $(`[data-user-name="${data.username}"]`);
          $disconnectedUser.removeClass('online');
        }
      },
    }
  );
});
