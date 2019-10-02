import Vue from 'vue'
import VueRouter from 'vue-router'
import { store } from './store/store.js'
Vue.use(VueRouter)

import Home from './components/index.vue'
import News from './components/widgets/news.vue'
import Weather from './components/widgets/weather.vue'
import Currencyexc from './components/widgets/currencyexc.vue'
import Dashboard from './components/dashboard.vue'
import Widgets from './components/widgets.vue'
import UserEdit from './users/edit.vue';
import Logout from './users/logout.vue';

const router = new VueRouter({
    mode: 'history',
    routes:[
        { path: '/', component: Home, name: 'root_path' },
        { path: '/users/:id/edit', component: UserEdit, name: 'edit_user_path' },
        { path: '/logout', component: Logout, name: 'logout_path' },
        { path: '/api/weather', component: Weather, name: 'weather_path' },
        { path: '/api/news', component: News, name: 'news_path' },
        { path: '/api/currencyexc', component: Currencyexc, name: 'currencyexc_path' },
        { path: '/dashboard', component: Dashboard, name: 'dashboard_path' },
        { path: '/widgets', component: Widgets, name: 'widgets_path' }
        
    ]
});
router.beforeEach((to, from, next) => {
    if (store.state.user) {
        store.dispatch('index');
        next();
    }
  })


export default router;