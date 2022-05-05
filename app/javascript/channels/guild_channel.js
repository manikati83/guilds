import consumer from "./consumer"

consumer.subscriptions.create("GuildChannel")

document.addEventListener("turbolinks:load", () => {
const data = document.getElementById("data")
if (data === null) {
  return
}
const channel = "GuildChannel"
const guild_id = data.getAttribute("data-guild-id")

if (!isSubscribed(channel, guild_id)) {
consumer.subscriptions.create({ channel: "GuildChannel", guild_id: guild_id}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const now_data = document.getElementById("data")
    if (now_data === null) {
      return
    }
    const guild_id = now_data.getAttribute("data-guild-id")
    // Called when there's incoming data on the websocket for this channel
    /*global $*/
    if (guild_id == data['guild_id']) {
      const sentence = '<div class="media"><div class="media-body">\
      <h5><img class="user-icon" src="https://secure.gravatar.com/avatar/' + data["address"] + '?s=30&d=mp" alt="">&nbsp;' + data["name"] + '</h5>\
      <p>' + data["message"] + '</p></div></div>'
      $('#message').append(sentence);
      
      var list;
      list = document.getElementById('message');
      list.scrollTo(0, list.scrollHeight);
    }
  },

  speak: function() {
  }
});
}
})


const isSubscribed = (channel, guild_id) => {
  const identifier = `{"channel":"${channel}","guild_id":"${guild_id}"}`
  const subscription = consumer.subscriptions.findAll(identifier)
  return !!subscription.length
}