import { customElement, property } from "lit/decorators.js";
import { LitElement, html } from "lit";
import { liveState } from "phx-live-state";

@customElement('hello-world')
@liveState({
  topic: 'hello_world',
  url: 'ws://localhost:4000/socket',
  properties: ['greeting'],
  events: {
    send: ['change-language']
  }
})
export class HelloWorldElement extends LitElement {
}