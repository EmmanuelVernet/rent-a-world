import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-price"
export default class extends Controller {
  static targets = ["startDate", "endDate", "bookingPrice"]
  static values = {
    price: Number,
    capacity: Number,
    unavailabilities: Array
  }

  connect() {
    // debug
    console.log("connected", {
      priceValue: this.priceValue,
      hasPriceValue: this.hasPriceValue,
      dataset: this.element.dataset,
      unavailabilitiesValue: this.unavailabilitiesValue
    })
    // Target calendar-range element
    const calendar = this.element.querySelector("calendar-range");
    
    if (!calendar) return;
    
    // Cally disallow dates if unavailabilities range include calendar dates
    calendar.isDateDisallowed = (date) => {
      // convert to date object to String then split
      const str = date.toISOString().split("T")[0];
      return this.unavailabilitiesValue.includes(str);
    };
  }
    
  bookingDates(event) { // change event
    const [startDate, endDate] = event.currentTarget.value.split("/")
    this.startDateTarget.value = startDate
    this.endDateTarget.value = endDate
    // Get time delta
    const start = new Date(startDate)
    const end = new Date(endDate)
    const bookingNights = (end - start) / (1000 * 60 * 60 * 24) // milliseconds timedelta conversion
    const bookingPrice = bookingNights * this.priceValue * this.capacityValue
    this.bookingPriceTarget.innerText = `Booking price for a party of 
    ${this.capacityValue} for ${bookingNights} nights → ${bookingPrice} €`
  }
}
