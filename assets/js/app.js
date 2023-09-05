// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import PhoenixCustomEventHook from 'phoenix-custom-event-hook';

import { mount } from "./mount"
import { ReactDemo } from "./react-demo"

ReactDemoHook = {
  mounted() {
    this.unmountComponent = mount(this.el.id, this.opts())
  },

  destroyed() {
    if (!this.unmountComponent) {
      console.error("ReactDemoRoot component not set")
      return;
    }

    this.unmountComponent()
  },

  opts() {
    return {}
  }
}


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken},
  hooks: {PhoenixCustomEventHook, ReactDemoHook}
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// import '@carbon/web-components/es/components/data-table/index.js';
// import '@carbon/web-components/es/components/pagination/index.js';
// import 'lit-google-map';
// import './pie-chart.js';
// import './hello-world.js';
// import './student-form.js';
// import './student-chat.js';
import "./react-demo.jsx";
