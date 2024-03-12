import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-account"
export default class extends Controller {
  connect() {
  }

  static targets = ["infos", "form", "card"]

  get userId() {
    return this.formTarget.dataset.userId;
  }

  displayForm() {
    this.infosTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }

  update(event) {
    event.preventDefault()
    const url = '/account/'
    console.log(url)
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget),
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data
      })
  }

}
