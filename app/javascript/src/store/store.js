import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({
    state: {
        user: {},
        widgets: {},
        selectedWidgets: {}     
    },
    mutations: {
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
        }
    },
    actions: {
        index(context) {
        $.ajax({
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', localStorage.csrf);
                xhr.setRequestHeader('Authorization', 'Bearer ' + localStorage.access);
              },
            url: '/api/home',
            type: 'get',
            dataType: "json",
            success: function(data) {
                console.log(data)
                context.commit('initUser', data.user)
                context.commit('initWidgets', data.widgets)
                context.commit('initSelectedWidgets', data.selectedWidgets)
            },
            error: function(xhr, textstatus) {
                delete localStorage.csrf
                delete localStorage.access
                delete localStorage.signedIn
                window.href.location = "/" 
            }
        })
        }        
    }
});