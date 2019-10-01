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
            url: '/api/welcome',
            type: 'get',
            dataType: "json",
            success: function(data) {
            console.log(data)
            context.commit('initUser', data.user)
            context.commit('initWidgets', data.widgets)
            context.commit('initSelectedWidgets', data.selectedWidgets)
            }
        })
        },        
    }
});