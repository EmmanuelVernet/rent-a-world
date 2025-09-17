import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static targets = ["calendar", "monthLabel"]

  connect() {
    this.displayCalendar()
  }

  displayCalendar() {
    const Calendar = window.tui.Calendar

    this.calendar = new Calendar(this.calendarTarget, {
      defaultView: "month",
      template: {
        time(event) {
          const { start, end, title } = event
          return `<span style="color: white;">${formatTime(start)}~${formatTime(end)} ${title}</span>`
        },
        allday(event) {
          return `<span style="color: gray;">${event.title}</span>`
        },
      },
    })

    this.updateMonthLabel()
  }

  prev() {
    this.calendar.prev()
    this.updateMonthLabel()
  }

  next() {
    this.calendar.next()
    this.updateMonthLabel()
  }

  today() {
    this.calendar.today()
    this.updateMonthLabel()
  }

  updateMonthLabel() {
    const date = this.calendar.getDate()
    const month = date.getMonth() + 1
    const year = date.getFullYear()
    const humanizedDate = new Date(year, month - 1);
    this.monthLabelTarget.textContent = humanizedDate.toLocaleDateString("en-US", {
      month: "long",
      year: "numeric"
    });
  }
}
