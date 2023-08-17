import { LitElement, html } from "lit";
import { customElement, property, query } from "lit/decorators.js";

type Field = {
  name: string;
  type: string;
  values?: string[];
}

@customElement('instacrud-form')
export class InstacrudFormElement extends LitElement {

  @property({type: Array})
  fields: Field[] = [];

  render() {
    return html`
      <form @submit=${this.save}>
        ${this.fields && this.fields.map(field => this.inputFor(field))}
        <button type="submit">Save</button>
      </form>
    `
  }

  inputFor(field: Field) {
    switch (field.type) {
      case 'select':
        return html`
        <div>
          <label for=${field.name}>${field.name}</label>
          <select name=${field.name}>
            ${field.values?.map(value => html`
              <option value=${value}>${value}</option>
            `)}
          </select>
        </div>
        `;
      case 'string':
        return html`
          <div>
            <label for=${field.name}>${field.name}</label>
            <input name=${field.name} type="text">
          </div>`;

      default:
        return html`
          <div>
            <label for=${field.name}>${field.name}</label>
            <input name=${field.name} type=${field.type}>
          </div>`;
    }
  }

  save(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    this.dispatchEvent(new CustomEvent('save', { detail: {student: data} }));
  }

}