import { Controller } from "@hotwired/stimulus"
import ConfettiGenerator from "confetti-js";


// Connects to data-controller="customconfetti"
export default class extends Controller {

  connect() {
    var confettiSettings = { target: this.element };
    var confetti = new ConfettiGenerator(confettiSettings);
    confetti.render();
  }
}
