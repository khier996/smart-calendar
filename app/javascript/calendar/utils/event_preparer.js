import moment from 'moment'

export default {
  prepareForCalendar(serverEvent) {
    return {
      start: serverEvent.start_time,
      end: serverEvent.end_time,
      title: serverEvent.title
    }
  },

  prepareForServer(calendarEvent) {
    calendarEvent.start = moment(calendarEvent.start).toISOString()
    calendarEvent.end = moment(calendarEvent.start).add(calendarEvent.duration, 'days').toISOString()

    return {
      start_time: calendarEvent.start,
      end_time: calendarEvent.end,
      title: calendarEvent.title
    }
  }
}
