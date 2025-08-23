import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-price"
export default class extends Controller {
  static targets = ["startDate", "endDate"]

  connect() {
  }
  
  bookingDates(event) {
    console.log("booking dates attached")
    const [startDate, endDate] = event.currentTarget.value.split("/")
    console.log(startDate)
    console.log(endDate)
    this.startDateTarget.value = startDate
    this.endDateTarget.value = endDate
  }

}
