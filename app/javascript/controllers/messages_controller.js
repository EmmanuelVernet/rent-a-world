import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  static targets = ["messages"]

  connect() {
    console.log("controller connected")
  }

  refreshMessages() {
    // fetch with interval
  }
}
