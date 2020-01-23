import axios from 'axios'

const internalApiInstance = axios.create()
internalApiInstance.interceptors.request.use(config => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  config.headers.post['X-CSRF-Token'] = token
  config.headers.put['X-CSRF-Token'] = token
  config.headers.delete['X-CSRF-Token'] = token

  return config
})

const externalApiInstance = axios.create()

export default {
  internal: internalApiInstance,
  external: externalApiInstance
}
