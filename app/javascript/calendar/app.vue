<template>
  <div id="app">
    <p class="title">Calendar</p>
    <FullCalendar ref="fullCalendar"
                  defaultView="dayGridMonth"
                  :plugins="calendarPlugins"
                  :events="calendarEvents"
                  @dateClick="handleDateClick"/>
    <create-event-popup v-if="isOpenCreatePopup" @createEvent="createEvent" />
  </div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'
import "@fullcalendar/core/main.css"
import "@fullcalendar/daygrid/main.css"
import axios from 'Calendar/axios'
import moment from 'moment'
import CreateEventPopup from 'Calendar/create_event_popup'

export default {
  components: { FullCalendar, CreateEventPopup },

  data: function () {
    return {
      calendarPlugins: [ dayGridPlugin, interactionPlugin ],
      api: undefined,
      chosenDate: undefined,
      isOpenCreatePopup: false,
      calendarEvents: [
        { title: 'Event Now', start: new Date(), end: '2020-01-28' }
      ]
    }
  },

  methods: {
    handleDateClick(e) {
      this.chosenDate = e.dateStr
      this.isOpenCreatePopup = true
    },

    createEvent(event) {
      event.start = this.chosenDate
      event.end = moment(event.start).add(event.duration - 1, 'days').format('YYYY-MM-DD')
    }
  },

  mounted() {
    this.api = this.$refs.fullCalendar.getApi()
    setTimeout(() => this.api.render()) // some weird issue with rendering referenced here - https://github.com/angular-ui/ui-calendar/issues/397

    axios.internal.post('/api/v1/events')
      .then(res => console.log(res))
  }
}
</script>

<style scoped lang="css">
.title {
  font-size: 2em;
  text-align: center;
}
</style>
