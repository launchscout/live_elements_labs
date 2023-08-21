import { LitElement, html } from "lit";
import { customElement, property, state } from "lit/decorators.js";
import { liveState, liveStateConfig } from 'phx-live-state';

@customElement("student-form")
@liveState({
  events: {
    send: ['register']
  },
  topic: 'student_form',
  url: 'ws://localhost:4000/socket',
  properties: ['status', 'errors'],
})
export class StudentFormElement extends LitElement {

  @state()
  status: string = '';

  @state()
  errors: Object = {};

  render() {
    if (this.status === 'complete') {
      return html`<p>Thank you for registering!</p>`;
    } else {
      return html`
        <form @submit=${this.submit}>
          <div>
            <label>First Name</label>
            <input name="first_name" type="text" />
            ${this.errorMessage('first_name')}
          </div>
          <div>
            <label>Last Name</label>
            <input name="last_name" type="text" />
            ${this.errorMessage('last_name')}
          </div>
          <div>
            <label>Email</label>
            <input name="email" type="email" />
            ${this.errorMessage('email')}
          </div>
          <div>
            <label>Experience Level</label>
            <select name="experience_level">
              <option value="beginner">Beginner</option>
              <option value="intermediate">Intermediate</option>
              <option value="expert">Expert</option>
            </select>
            ${this.errorMessage('experience_level')}
          </div>
          <button type="submit">Register</button>
        </form>
      `;
    }
  }

  errorMessage(field) {
    if (this.errors && this.errors[field]) {
      return html`<div class="error">${this.errors[field]}</div>`;
    } else {
      return html``;
    }
  }

  submit(event: Event) {
    event.preventDefault();
    const form = event.target as HTMLFormElement;
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());
    this.dispatchEvent(new CustomEvent('register', { detail: data }));
  }
}