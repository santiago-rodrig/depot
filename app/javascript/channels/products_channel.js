import consumer from "./consumer"

consumer.subscriptions.create("ProductsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    document.getElementsByTagName('main')[0].innerHTML = data.html;
    // let's try with this one
    // 1. if it works it means that data is being passed as string always
    document.getElementById('product-' + data.product_id)
      .classList.add('lineitem-highlight');
    // this one will work for sure
    // document.getElementById('product-' + data.product_id.toString())
  }
});
