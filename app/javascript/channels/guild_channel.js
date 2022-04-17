import consumer from "./consumer"

consumer.subscriptions.create("GuildChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    /*global $*/
    $('.message').append("<p>" + data['message'] + "</p>");
  },

  speak: function() {
  }
});