import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-bell"
export default class extends Controller {
  static targets = [ "counter", "list" ]
  static values = { 
    counterUrl: String,
    notificationUrl: String, 
    interval: { type: Number, default: 10000 } 
    }

  connect() {
    this.updateNotificationsCounter() // fetch counter
    this.refreshNotificationsList() // then update notif list
    this.refresh() // then update every 10 seconds
  }

  refresh () {
    setInterval(() => this.updateNotificationsCounter(), this.intervalValue)
  }
  
  async updateNotificationsCounter() {
    const url = this.counterUrlValue;
    try {
      const response = await fetch(url, { 
        headers: { "Accept": "application/json" }
      });
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

  async refreshNotificationsList() {
    try {
      const response = await fetch(this.notificationUrlValue, { 
        headers: { "Accept": "text/html" },
        credentials: "same-origin"
      })
      console.log(response)
      if (response.ok) {
        this.listTarget.innerHTML = await response.text()
      }
    } catch (e) {
      console.error(e)
    }
  }
}
