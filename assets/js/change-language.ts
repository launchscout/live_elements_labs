import { html, LitElement } from 'lit'
import { customElement, property } from 'lit/decorators.js'

@customElement('change-language')
export class ChangeLanguageElement extends LitElement {

  @property({ type: Object })
  greetings: Object;

  render() {
    return html`
    <select @change=${this.changeLanguage} name="language">
      ${Object.keys(this.greetings).map(language => html`
        <option>${language}</option>
      `)}
    </select>`; 
  }

  changeLanguage(event) {
    this.dispatchEvent(new CustomEvent('change-language', {detail: {language: event.target.value}}))
    console.log(event.target.value);
  }
}