import Vue from 'vue/dist/vue.js';
import SessionNewView from 'src/users/session';
new Vue({
    el: '#sessions-new-view',
    components: {
        'sessions-new-view': SessionNewView
    }
});