<template>
  <div id="app">
    <p class="title">Calendar</p>
    <FullCalendar ref="fullCalendar" defaultView="dayGridMonth" :plugins="calendarPlugins" />
  </div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import "@fullcalendar/core/main.css"
import "@fullcalendar/daygrid/main.css"
import axios from 'Calendar/axios'

export default {
  components: { FullCalendar },

  data: function () {
    return {
      calendarPlugins: [ dayGridPlugin ],
      api: undefined
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
