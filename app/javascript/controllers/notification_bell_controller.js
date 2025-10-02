import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-bell"
export default class extends Controller {
  static targets = [ "counter" ]
  static values = { url: String, 
                    interval: { 
                      type: Number, 
                      default: 3000 
                    } 
                  }

  connect() {
    this.updateNotificationCounter()
  }
  
  async updateNotificationCounter() {
    const url = this.urlValue;
    try {
      const response = await fetch(url,{ headers: { "Accept": "application/json" }});
      if (!response.ok) {
        throw new Error(`Response status: ${response.status}`);
      }

      const result = await response.json();
      console.log(result);
    } catch (error) {
      console.error(error.message);
    }
  }
}
