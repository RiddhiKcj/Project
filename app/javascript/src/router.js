import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Index from '../src/components/index.vue'
import News from '../src/components/widgets/news.vue'
import Weather from '../src/components/widgets/weather.vue'
import Dashboard from '../src/components/dashboard.vue'
import Widgets from '../src/components/widgets.vue'
import UserEdit from '../src/users/edit.vue';
import UserNew from '../src/users/new.vue';

const router = new VueRouter({
    mode: 'history',
    routes:[
        { path: '/', component: Index, name: 'root_path' },
        { path: '/api/users/new', component: UserNew, name: 'new_user_path' },
        { path: '/users/:id/edit', component: UserEdit, name: 'edit_user_path' },
        { path: '/weather', component: Weather, name: 'weather_path' },
        { path: '/news', component: News, name: 'news_path' },
        { path: '/dashboard', component: Dashboard, name: 'dashboard_path' },
        { path: '/widgets', component: Widgets, name: 'widgets_path' }
        
    ]
});
export default router;