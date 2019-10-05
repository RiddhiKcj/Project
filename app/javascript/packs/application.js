import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import App from '../app.vue'
import router from '../src/router.js'
import Layout from '../src/shared/layout.vue'
import { store } from '../src/store/store'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from '../src/backend/axios'

Vue.use(Vuetify)
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})
Vue.component('layout',Layout)
document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    vuetify: new Vuetify({}),
    router,
    store,
    securedAxiosInstance,
    plainAxiosInstance,
    render: h => h(App),
  })
  console.log(app)
})
