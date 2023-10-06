import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["knowsGir", "girSelection", "girDescription"]

  connect() {
    this.toggleGirVisibility()
  }

  toggleGirVisibility() {
    const anyRadioChecked = this.knowsGirTargets.some(radio => radio.checked);

    if (anyRadioChecked) {
        const knowsGir = this.knowsGirTarget.checked;
        this.girSelectionTarget.style.display = knowsGir ? "block" : "none";
        this.girDescriptionTarget.style.display = knowsGir ? "none" : "block";
    } else {
        this.girSelectionTarget.style.display = "none";
        this.girDescriptionTarget.style.display = "none";
    }
}

}
