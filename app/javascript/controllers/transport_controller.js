import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["transportType", "transitOption", "routingPreference"];

  connect() {
    this.toggleTransportOptions();
  }

  change(event) {
    this.toggleTransportOptions(event.currentTarget.value);
  }

  toggleTransportOptions(value) {
    const isPublicTransport = value === "Transports en commun";
    this.transitOptionTarget.classList.toggle("d-none", !isPublicTransport);
    this.routingPreferenceTarget.classList.toggle("d-none", !isPublicTransport);
  }

}
