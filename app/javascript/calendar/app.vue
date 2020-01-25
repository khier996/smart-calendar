<template>
  <div id="app">
    <p class="title">Calendar</p>
    <FullCalendar ref="fullCalendar"
                  defaultView="dayGridMonth"
                  :plugins="calendarPlugins"
                  :events="calendarEvents"
                  @dateClick="handleDateClick"/>
    <create-event-popup v-if="isOpenCreatePopup"
                        @createEvent="createEvent"
                        @close="closeCreatePopup" />
  </div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'
import "@fullcalendar/core/main.css"
import "@fullcalendar/daygrid/main.css"
import CreateEventPopup from 'Calendar/create_event_popup'
import apis from 'Calendar/apis'
import eventPreparer from 'Calendar/utils/event_preparer'

export default {
  components: { FullCalendar, CreateEventPopup },

  data: function () {
    return {
      calendarPlugins: [ dayGridPlugin, interactionPlugin ],
      calendarApi: undefined,
      chosenDate: undefined,
      isOpenCreatePopup: false,
      calendarEvents: []
    }
  },

  methods: {
    fetchEvents() {
      apis.fetchEvents()
        .then(res => {
          let events = res.data.map(serverEvent => {
            return eventPreparer.prepareForCalendar(serverEvent)
          })
          console.log(events)
          this.calendarEvents = events
        })
    },

    handleDateClick(e) {
      this.chosenDate = e.dateStr
      this.isOpenCreatePopup = true
    },

    createEvent(calendarEvent) {
      calendarEvent.start = this.chosenDate
      let serverEvent = eventPreparer.prepareForServer(calendarEvent)
      apis.createEvent(serverEvent)
        .then(res => {
          console.log(res)
          let calendarEvent = eventPreparer.prepareForCalendar(res.data)
          this.calendarEvents.push(calendarEvent)
          this.closeCreatePopup()
        })
    },

    closeCreatePopup() {
      this.isOpenCreatePopup = false
    }
  },

  mounted() {
    this.calendarApi = this.$refs.fullCalendar.getApi()
    setTimeout(() => this.calendarApi.render()) // some weird issue with rendering referenced here - https://github.com/angular-ui/ui-calendar/issues/397
    this.fetchEvents()
  }
}
</script>

<style scoped lang="css">
.title {
  font-size: 2em;
  text-align: center;
}
</style>
