import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';


document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    plugins: ['dayGridPlugin'],
    events: '/public/shifts.json',  // シフトデータの JSON をロード
    initialView: 'dayGridMonth'
  });
  calendar.render();
});