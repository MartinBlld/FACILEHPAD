import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = { apiKey: String }
  static targets = [ "adresseDeRecherche" ]  // CamelCase ici

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    })
    this.geocoder.setCountries('FR');
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    this.adresseDeRechercheTarget.value = event.result["place_name"]  // CamelCase ici aussi
  }

  #clearInputValue() {
    this.adresseDeRechercheTarget.value = ""  // Et ici
  }

  disconnect() {
    this.geocoder.onRemove()
  }
}
