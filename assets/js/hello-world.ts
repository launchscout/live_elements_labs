import { customElement, property } from "lit/decorators.js";
import { LitElement, html } from "lit";

@customElement('hello-world')
export class HelloWorldElement extends LitElement {
  @property({type: String})
  greeting = '';

  render() {
    return html`<h1>${this.greeting} <slot></slot>!</h1>`;
  }
}