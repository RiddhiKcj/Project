import axios from 'axios'
import { store } from '../../store/store'

const API_URL = 'http://localhost:3000'

const securedAxiosInstance = axios.create({
    baseURL: API_URL,
    withCredentials: true,
    headers: {
    'Content-Type': 'application/json'
    }
})

const plainAxiosInstance = axios.create({
    baseURL: API_URL,
    withCredentials: true,
    headers: {
    'Content-Type': 'application/json'
    }
})

securedAxiosInstance.interceptors.request.use(config => {
    const method = config.method.toUpperCase()
    if (method !== 'OPTIONS' && method !== 'GET') {
        config.headers = {
            ...config.headers,
            'X-CSRF-TOKEN': store.state.csrf,
            'Authorization': 'Bearer ' +  store.state.access
        }
    }
    return config
})

securedAxiosInstance.interceptors.response.use(null, error => {
    if (error.response && error.response.config && error.response.status === 401) {
        return plainAxiosInstance.post('/refresh', {}, { headers: { 'X-CSRF-TOKEN': localStorage.csrf } })
            .then(response => {
            store.commit('refresh', {csrf: response.data.csrf, access: response.data.access})
            let retryConfig = error.response.config
            retryConfig.headers['X-CSRF-TOKEN'] = store.state.csrf
            retryConfig.headers['Authorization'] = 'Bearer ' + store.state.access
            return plainAxiosInstance.request(retryConfig)
            }).catch(error => {
            store.commit('unsetSession')
            location.replace('/')
            return Promise.reject(error)
        })
    } 
    else {
        return Promise.reject(error)
    }
})

export { securedAxiosInstance, plainAxiosInstance }