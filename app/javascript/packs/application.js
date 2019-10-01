import Vue from 'vue';
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import router from '../src/router.js';

import NavTop from '../src/shared/_nav_top';
Vue.component('nav-top', NavTop);

$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
  },
  complete: function(xhr, status) {
    if(xhr.status === 200 || xhr.status === 422) {
      return true;
    }
    else {
        console.log("An error Occured: packs->app.js")
    }
  }
})

const app = new Vue({
  vuetify: new Vuetify({}),
  router,
  render: h => h(App),
})
