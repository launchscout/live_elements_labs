import { customElement, property } from "lit/decorators.js";
import { LitElement, html } from "lit";

@customElement('hello-world')
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