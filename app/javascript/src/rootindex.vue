<template>  
    <v-app id="inspire">
        <v-card color="black">
            <v-card-title class="text-center justify-center py-6">
                <h1 class="font-weight-bold display-1 basil--text">WIDGETS APPLICATION</h1>
            </v-card-title>
            <v-tabs v-model="tab" background-color="transparent" color="green" grow>
                <v-tab> LOGIN </v-tab>
                <v-tab> SIGNUP </v-tab>
            </v-tabs>
            <v-tabs-items v-model="tab">
                <v-tab-item>
                    <v-card flat color="basil">
                    <login></login>
                    </v-card>
                </v-tab-item>
                <v-tab-item>
                    <v-card flat color="basil">
                        <signup></signup>
                    </v-card>
                </v-tab-item>
            </v-tabs-items>
        </v-card>
    </v-app>
</template>
    
<script>
import Login from './users/session.vue';
import Signup from './users/new.vue';
export default {
  components: {
    'login' : Login,
    'signup' : Signup
  },
  data () {
        return {
            tab: null
        }
    },
  created () {
        this.$vuetify.theme.dark = true
    },
}
</script>
<style scoped>
    .basil {
        background-color: #FFFBE6 !important;
    }
    .basil--text {
        color: white !important;
    }
    .v-tab{
        color: white !important;
    }
    .v-tab--active{
        color: green !important;
    }
</style>