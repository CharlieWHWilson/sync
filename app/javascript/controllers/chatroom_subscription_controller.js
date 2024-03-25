import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { gameId: Number }
  static targets = ["messages"]

  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.gameIdValue },
      { received: data => this.messagesTarget.insertAdjacentHTML("beforeend", data)}
    )
    console.log(`Subscribed to the chatroom with the id ${this.gameIdValue}.`)
  }
}