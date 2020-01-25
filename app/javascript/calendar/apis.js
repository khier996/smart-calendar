import axios from 'Calendar/axios'

export default {
  fetchEvents() {
    return axios.internal.get('/api/v1/events')
  },

  createEvent(serverEvent) {
    return axios.internal.post('/api/v1/events', { event: serverEvent })
  }
}
