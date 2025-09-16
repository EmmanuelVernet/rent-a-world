import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static targets = ["calendar"]

  connect() {
    console.log("calendar controller connected!")
    this.displayCalendar();
  }

  displayCalendar() {
  const Calendar = window.tui.Calendar;
  const calendar = new Calendar('#calendar', {
    defaultView: 'month',
    template: {
      time(event) {
        const { start, end, title } = event;

        return `<span style="color: white;">${formatTime(start)}~${formatTime(end)} ${title}</span>`;
      },
      allday(event) {
        return `<span style="color: gray;">${event.title}</span>`;
      },
    },
    calendars: [
      {
        id: 'cal1',
        name: 'Personal',
        backgroundColor: '#03bd9e',
      },
      {
        id: 'cal2',
        name: 'Work',
        backgroundColor: '#00a9ff',
      },
    ],
  });

  }
}
