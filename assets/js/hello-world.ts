import { customElement, property } from "lit/decorators.js";
import { LitElement, html } from "lit";

@customElement('hello-world')
export class HelloWorldElement extends LitElement {

  @property()
  greeting: string = '';

  render() {
    return html`
      ${this.greeting} <slot></slot>
      <select @change=${this.changeLanguage} name="language">
        <option>German</option>
        <option>French</option>
      </select>
    `
  }

  changeLanguage(event) {
    console.log(event.target.value);
  }
}