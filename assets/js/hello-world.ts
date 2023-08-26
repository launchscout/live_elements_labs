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
  @property({type: String})
  greeting = '';

  render() {
    return html`
      <h1>${this.greeting} <slot></slot>!</h1>
      <select @change=${this.changeLanguage}>
        <option>English</option>
        <option>French</option>
        <option>German</option>
      </select>
    `;
  }

  changeLanguage(event) {
    this.dispatchEvent(new CustomEvent('change-language', { detail: {language: event.target.value} }));
  }
}