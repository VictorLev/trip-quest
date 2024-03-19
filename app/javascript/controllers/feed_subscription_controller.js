import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="feed-subscription"
export default class extends Controller {
  static values = { feedId: Number }
  static targets = ["posts"]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "FeedChannel", id: this.feedIdValue },
      { received: data => this.#insertPostAndScrollDown(data)}
    )
  }
  #insertPostAndScrollDown(data) {
    this.postsTarget.insertAdjacentHTML("afterbegin", data)
    // window.scrollTo(0, document.body.scrollHeight);
    // const posts = document.querySelector(".posts")
    // posts.scrollTo(0, posts.scrollHeight);
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
