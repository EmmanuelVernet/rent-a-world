import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-bell"
export default class extends Controller {
  static targets = [ "counter", "list" ]
  static values = { 
    counterUrl: String, 
    interval: { type: Number, default: 3000 } 
    }

  connect() {
    this.refresh()
  }

  refresh () {
    setInterval(() => this.updateNotificationsCounter(), this.intervalValue)
  }
  
  async updateNotificationsCounter() {
    const url = this.counterUrlValue;
    try {
      const response = await fetch(url,{ headers: { "Accept": "application/json" }});
      if (!response.ok) {
        throw new Error(`Response status: ${response.status}`);
      }

      const result = await response.json();
      // console.log(result);
      this.counterTarget.textContent = result.count
    } catch (error) {
      console.error(error.message);
    }
  }
}
