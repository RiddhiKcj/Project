import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import SessionNew from '../src/admin/users/session.vue';
import UserNew from '../src/admin/users/new.vue';
import RootIndex from '../src/rootindex.vue';

const router = new VueRouter({
    mode: 'history',
    routes:[
        { path: '/', component: RootIndex, name: 'root_path' },
        { path: '/createuser', component: UserNew, name: 'new_user_path' },
        { path: '/login', component: SessionNew, name: 'new_session_path' }      
    ]
});

export default router;