import consumer from "./consumer"

consumer.subscriptions.create({ channel: "GuildChannel", room: "Best Room"}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    /*global $*/
    $('#message').append("<p>" + data['message'] + "</p>");
    
    var list;
    list = document.getElementById('message');
    list.scrollTo(0, list.scrollHeight);
  },

  speak: function() {
  }
});