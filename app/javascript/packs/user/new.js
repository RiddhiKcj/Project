import Vue from 'vue/dist/vue.js';
import UsersNewView from 'src/users/new';
new Vue({
    el: '#users-new-view',
    components: {
        'users-new-view': UsersNewView
    }
});