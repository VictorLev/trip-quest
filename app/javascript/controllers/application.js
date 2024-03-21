import { Application } from "@hotwired/stimulus"
import { Confetti } from "stimulus-confetti"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// application.register('confetti', Confetti)

export { application }
