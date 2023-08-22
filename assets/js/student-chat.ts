import { LitElement, html } from 'lit'
import { customElement, property, query, state } from 'lit/decorators.js'
import { liveState } from 'phx-live-state'

type ChatMessage = {
  from: string;
  content: string;
}

@customElement('student-chat')
@liveState({
  topic: 'student_chat',
  url: 'ws://localhost:4000/socket',
  properties: ['messages', 'channel_id'],
  events: {
    send: ['new_message', 'start_chat']
  }
})
export class StudentChatElement extends LitElement {
  
  @property()
  url = '';

  @state()
  messages: Array<ChatMessage> = [];

  @state()
  name: string | undefined;

  @state()
  channel_id: Number | undefined;

  @query('input[name="name"]')
  nameInput: HTMLInputElement | undefined;

  @query('input[name="message"]')
  messageInput: HTMLInputElement | undefined;

  @query('dialog')
  dialog: HTMLDialogElement | undefined;

  render() {
    return html`
    <button @click=${this.openDialog}>Chat with instructor</button>
    <dialog>
    ${this.channel_id ? html`
      <ul>
        ${this.messages.map(message => html`<li>${message.from}: ${message.content}</li>`)}
      </ul>
      <label>Message: <input name="message"></label>
      <button @click=${this.sendMessage}>Send Message</button>
    ` : html `
      <label>Name:<input name="name" /></label>
      <button @click=${this.startChat}>Start Chat</button>
    `}
    </dialog>
    `;
  }

  openDialog() {
    this.dialog!.showModal();
  }

  startChat() {
    this.dispatchEvent(new CustomEvent('start_chat', {detail: {name: this.nameInput?.value}}))
    this.name = this.nameInput?.value;
    this.nameInput!.value = '';
  }

  sendMessage() {
    this.dispatchEvent(new CustomEvent('new_message', {detail: {message: this.messageInput?.value}}))
    this.messageInput!.value = '';
  }
}

declare global {
  interface HTMLElementTagNameMap {
    'student-chat': studentChatElement
  }
}
