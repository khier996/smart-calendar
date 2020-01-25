import axios from 'axios'

// this variable is currently used only for testing to know when all ajax requests are completed
window.calendarPendingRequests = 0

const internalApiInstance = axios.create()
internalApiInstance.interceptors.request.use(config => {
  debugger
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  config.headers.post['X-CSRF-Token'] = token
  config.headers.put['X-CSRF-Token'] = token
  config.headers.delete['X-CSRF-Token'] = token

  return config
})

internalApiInstance.interceptors.request.use(config => {
  window.calendarPendingRequests++
  return config
})

internalApiInstance.interceptors.response.use(response => {
  window.calendarPendingRequests--
  return response
})

const externalApiInstance = axios.create()

export default {
  internal: internalApiInstance,
  external: externalApiInstance
}

