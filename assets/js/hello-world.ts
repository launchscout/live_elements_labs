import { customElement, property } from "lit/decorators.js";
import { LitElement, html } from "lit";

@customElement('hello-world')
export class HelloWorldElement extends LitElement {

  @property()
  greeting: string = '';

  @property({type: Object})
  greetings: Object;

  render() {
    return html`
      ${this.greeting} <slot></slot>
    `
  }

}