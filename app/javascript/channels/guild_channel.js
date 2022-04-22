import consumer from "./consumer"

document.addEventListener("turbolinks:load", () => {
  const data = document.getElementById("data")
  if (data === null) {
    return
　}
　const channel = "GuildChannel"
  const guild_id = data.getAttribute("data-guild-id")
  const user_id = data.getAttribute("data-user-id")
　
　if (!isSubscribed(channel, guild_id, user_id)) {
    consumer.subscriptions.create(
      { channel: "GuildChannel", guild_id: guild_id, user_id: user_id }, {
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
      }
    )
　}
  });
  
  
  const isSubscribed = (channel, room_id, user_id) => {
   const identifier = `{"channel":"${channel}","room_id":"${room_id}","user_id":"${user_id}"}`
   const subscription = consumer.subscriptions.findAll(identifier)
   return !!subscription.length
 }