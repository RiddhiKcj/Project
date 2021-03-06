import Vue from 'vue'
import VueRouter from 'vue-router'
import { store } from './store/store'
Vue.use(VueRouter)

import RootIndex from './rootindex.vue'
import Index from '../src/components/index.vue'
import News from '../src/components/widgets/news.vue'
import Weather from '../src/components/widgets/weather.vue'
import Currencyexc from '../src/components/widgets/currencyexc.vue'
import Movies from '../src/components/widgets/movies.vue'
import Dashboard from '../src/components/dashboard.vue'
import Widgets from '../src/components/widgets.vue'
import UserEdit from '../src/users/edit.vue';
import UserNew from '../src/users/new.vue';
import MovieDetails from '../src/components/widgets/movies/details.vue'

const router = new VueRouter({
    mode: 'history',
    routes:[
        { path: '/', component: RootIndex, name: 'root_path' },
        { path: '/home', component: Index, name: 'home_path' },
        { path: '/createuser', component: UserNew, name: 'new_user_path' },
        { path: '/users/:id/edit', component: UserEdit, name: 'edit_user_path' },
        { path: '/api/weather', component: Weather, name: 'weather_path' },
        { path: '/api/news', component: News, name: 'news_path' },
        { path: '/api/currencyexc', component: Currencyexc, name: 'currencyexc_path' },
        { path: '/api/movies', component: Movies, name: 'movies_path' },
        { path: '/dashboard', component: Dashboard, name: 'dashboard_path' },
        { path: '/widgets', component: Widgets, name: 'widgets_path' },
        { path: '/api/movies/:movie_id', component: MovieDetails, name: 'movie_path' },
        { path: '*' , redirect: '/home'}      
    ]
});
router.beforeEach((to, from, next) => {
    if ( to.fullPath !== '/' ) {
        if ( !store.state.signedIn ){
            next('/')
        }
        else {
            next();
        }       
    }
    else {
        next();
    }
  })


export default router;