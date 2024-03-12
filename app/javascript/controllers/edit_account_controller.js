import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-account"
export default class extends Controller {
  connect() {
  }

  static targets = ["infos", "form"]


  displayForm() {
    this.infosTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }

}
