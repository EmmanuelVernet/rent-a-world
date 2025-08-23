import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-price"
export default class extends Controller {
  static targets = ["startDate", "endDate", "bookingPrice"]
  static values = {
    price: Number,
    capacity: Number
  }

  connect() {
    // debug
    console.log("connected", {
      priceValue: this.priceValue,
      hasPriceValue: this.hasPriceValue,
      dataset: this.element.dataset
    })
  }
    
  bookingDates(event) {
    const [startDate, endDate] = event.currentTarget.value.split("/")
    this.startDateTarget.value = startDate
    this.endDateTarget.value = endDate
    // Get time delta
    const start = new Date(startDate)
    const end = new Date(endDate)
    const bookingNights = (end - start) / (1000 * 60 * 60 * 24) // milliseconds timedelta conversion
    const bookingPrice = bookingNights * this.priceValue * this.capacityValue
    this.bookingPriceTarget.innerText = `Booking price for ${bookingNights} nights → ${bookingPrice} €`
  }
}
