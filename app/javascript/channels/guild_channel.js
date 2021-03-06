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
    if (data['join_user_id']) {
      if (guild_id == data['guild_id']){
        const join_user = document.getElementById(data['join_user_id']);
        if (!join_user.children[1].classList.contains("join")){
          join_user.children[1].classList.add('join');
        }
        if (!join_user.classList.contains("online")){
          join_user.classList.add('online')
        }
      }
    }else if (data['out_user_id']) {
      if (guild_id == data['guild_id']){
        const out_user = document.getElementById(data['out_user_id']);
        if (out_user.children[1].classList.contains("join")){
          out_user.children[1].classList.remove('join');
        }
      }
    }else if (guild_id == data['guild_id']) {
      const message = data["message"].replace(/(\r\n|\n|\r)/gm, '<br>')
      const sentence = '<div class="media chat-media"><div class="media-body">\
      <h5><img class="user-icon" src="https://secure.gravatar.com/avatar/' + data["address"] + '?s=30&d=mp" alt="">&nbsp;' + data["name"] + '</h5>\
      <p>' + message + '</p></div></div>'
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