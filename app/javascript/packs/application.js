import Vue from 'vue';
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import router from '../src/routes.js';
import App from '../app.vue'
Vue.use(Vuetify)

// const app = new Vue({
//   
//   router,
//   render: h => h(App),
// })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router: router,
    vuetify: new Vuetify({}),
    render: h => h(App),
  })
  console.log(app)
})