import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
    // initialize checkbox and theme
    const theme = localStorage.getItem("theme") || "light"
    const isDark = theme === "dim"

    document.documentElement.classList.toggle("dim", isDark)

    // set checked property
    if (this.hasCheckboxTarget) {
      this.checkboxTarget.checked = isDark
    }
  }

  toggle() {
    const isDark = this.checkboxTarget.checked
    document.documentElement.classList.toggle("dim", isDark)
    localStorage.setItem("theme", isDark ? "dim" : "light")
  }
}
