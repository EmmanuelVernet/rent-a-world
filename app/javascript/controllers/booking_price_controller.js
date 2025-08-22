import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-price"
export default class extends Controller {
  connect() {
    console.log("booking price controller connected")
  }
}
