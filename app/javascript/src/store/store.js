import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate'
Vue.use(Vuex);

export const store = new Vuex.Store({
    state: {
        user: {},
        widgets: {},
        selectedWidgets: {},
        signedIn: false,
        csrf: null,
        access: null
    },
    mutations: {
        setSession(state,{csrf,access}) {
            state.signedIn = true
            state.csrf = csrf
            state.access = access
        },
        unsetSession(state) {
            state.signedIn = false
            state.csrf = null
            state.access = null
        },
        refresh (state, {csrf,access}) {
            state.signedIn = true
            state.csrf = csrf
            state.access = access
        },
        initUser(state,data) {
            state.user = data;
            return state;
        },
        initWidgets(state,data) {
            state.widgets = data;
            return state;
        },
        initSelectedWidgets(state,data) {
            state.selectedWidgets = data;
            return state;
        },
        emptyStore(state) {
            state.user = {};
            state.widgets = {},
            state.selectedWidgets = {};
        },
        
    },
    actions: {
        index(context) {
        $.ajax({
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', context.state.csrf);
                xhr.setRequestHeader('Authorization', 'Bearer ' + context.state.access);
            },
            url: '/api/home',
            type: 'get',
            dataType: "json",
            success: function(data) {
                context.commit('initUser', data.user)
                context.commit('initWidgets', data.widgets)
                context.commit('initSelectedWidgets', data.selectedWidgets)
            },
            error: function(xhr, textstatus) {
                delete localStorage.csrf
                delete localStorage.access
                delete localStorage.signedIn
                context.commit('unsetSession')
                context.commit('emptyStore')
                window.href.location = "/" 
            }
        })
        }        
    },
    plugins: [createPersistedState()]
});