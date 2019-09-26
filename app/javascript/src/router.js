import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Index from '../src/components/index.vue'
import News from '../src/components/wizards/news.vue'
import Weather from '../src/components/wizards/weather.vue'

const router = new VueRouter({
    mode: 'history',
    routes:[
        { path: '/', component: Index, name: 'root_path' },
        { path: '/weather', component: Weather, name: 'weather_path' },
        { path: '/news', component: News, name: 'news_path' }
    ]
});
export default router;