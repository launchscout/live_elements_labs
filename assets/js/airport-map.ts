import { LitElement, html, css } from 'lit'
import { customElement, property, query, state } from 'lit/decorators.js'
import { liveState } from 'phx-live-state';
import 'lit-google-map';

type Airport = {
  name: string;
  identifier: string;
  latitude: number;
  longitude: number;
}

@customElement('airport-map')
@liveState({
  topic: 'airport_map',
  url: 'ws://localhost:4000/socket',
  properties: ['airports'],
  events: {
    send: ['tilesloaded', 'bounds_changed']
  }
})
export class AirportMapElement extends LitElement {
  
  @property({attribute: 'api-key'})
  apiKey: string = '';

  @state()
  airports: Array<Airport> = [];

  render() {
    return html`
      <div class="map">
        <lit-google-map api-key=${this.apiKey} version="3.46">
          ${this.airports?.map(({name, identifier, latitude, longitude}) => html`
            <lit-google-map-marker slot="markers" latitude=${latitude} longitude=${longitude}>
              <p>${name} (${identifier})</p>
            </lit-google-map-marker>        
          `)}
        </lit-google-map>
      </div>    
    `;
  }
}

declare global {
  interface HTMLElementTagNameMap {
    'airport-map': AirportMapElement
  }
}
