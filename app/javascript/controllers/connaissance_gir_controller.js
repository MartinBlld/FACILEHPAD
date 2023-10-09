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

        // Disable or enable inputs based on visibility
        this.setInputsDisabled(this.girSelectionTarget, !knowsGir);
        this.setInputsDisabled(this.girDescriptionTarget, knowsGir);
    } else {
        this.girSelectionTarget.style.display = "none";
        this.girDescriptionTarget.style.display = "none";

        // Disable inputs when sections are hidden
        this.setInputsDisabled(this.girSelectionTarget, true);
        this.setInputsDisabled(this.girDescriptionTarget, true);
    }
  }

  setInputsDisabled(element, disabled) {
    element.querySelectorAll('input').forEach(input => input.disabled = disabled);
  }
}
