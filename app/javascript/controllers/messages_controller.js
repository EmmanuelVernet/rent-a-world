import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages"
export default class extends Controller {
  static values = { url: String, interval: { type: Number, default: 3000 } }
  static targets = ["list"]

  connect() {
    this.start()
  }

  disconnect() {
    this.stop()
  }

  start() {
    this.timer = setInterval(() => this.refresh(), this.intervalValue)
  }

  stop() {
    clearInterval(this.timer)
  }

  async refresh() {
    try {
      const response = await fetch(this.urlValue, { headers: { "Accept": "text/html" } })
      if (response.ok) {
        this.listTarget.innerHTML = await response.text()
      }
    } catch (e) {
      console.error(e)
    }
  }
}
