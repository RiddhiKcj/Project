<template>
    <div>
        <v-navigation-drawer v-model="drawer" app floating persistent mobile-break-point="991" width="260">
            <v-layout class="fill-height" tag="v-list" column>
                <v-list-item>
                    <v-list-item-content> 
                        <v-list-item-title>
                            <h4><v-icon>mdi-star-circle</v-icon>WIDGETS APP</h4>
                        </v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-divider></v-divider>
                <v-list-item @click="navigateHome">
                    <v-list-item-action>
                        <v-icon>mdi-home</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                        <v-list-item-title>Home</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item @click="navigateDashboard">
                    <v-list-item-action>
                        <v-icon>mdi-view-dashboard</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                        <v-list-item-title>Dashboard</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item @click="navigateWidgets">
                    <v-list-item-action>
                        <v-icon>mdi-apps</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                        <v-list-item-title>Widgets</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item @click="navigateProfileEdit">
                    <v-list-item-action>
                        <v-icon>mdi-face</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                        <v-list-item-title>Edit Profile</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item @click="LogoutSession">
                    <v-list-item-action>
                        <v-icon>mdi-logout</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                        <v-list-item-title>Logout</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-layout>
        </v-navigation-drawer>           
        <v-app-bar app flat clipped-left style="background: #eee; color:black">
        <v-app-bar-nav-icon  @click.stop="drawer = !drawer" color="black"></v-app-bar-nav-icon>
        <div class="flex-grow-1"></div>  
        <v-toolbar-title right>
            <v-avatar color="indigo">
                <v-icon dark>mdi-account-circle</v-icon>
            </v-avatar> {{currentUser}}</v-toolbar-title>
        </v-app-bar>
        <v-content class="pt-12"> 
        <div id="core-view"></div>    
            <slot/>
        </v-content> 
        <v-footer app>
                <span>&copy; 2019</span>
        </v-footer>             
    </div>     
</template>
<script>
export default {
    data: () => ({
        drawer: null,
        user_id: null
    }),
    computed: {
        currentUser(){
            this.user_id = this.$store.state.user.id;
            return this.$store.state.user.username;
        },
    },
    methods: {
        navigateHome() {
            this.$router.push({path: '/home'});
        },
        navigateDashboard() {
            this.$router.push({path: '/dashboard'});
        },
        navigateWidgets() {
            this.$router.push({path: '/widgets'});
        },
        navigateProfileEdit() {
            this.$router.push({path: '/users/' + this.user_id +'/edit'});
        },
        LogoutSession() {
            var self = this;
            this.$http.secured.delete('/signin')
            .then(response => {
                delete localStorage.csrf
                delete localStorage.access
                delete localStorage.signedIn
                self.$store.commit('emptyStore')
                self.$store.commit('unsetSession')
                self.$router.replace('/')
            })
            .catch(error => this.setError(error, 'Cannot sign out'))
        }
    },
    created () {
        this.$vuetify.theme.dark = true;
    },
}
</script>
<style>
    .v-toolbar__title{
        text-transform: capitalize;
    }
    .v-image{
        background-position: center center;
        background-repeat: no-repeat;
        background-size: cover;
    }
    .v-navigation-drawer{
        background:  linear-gradient(rgba(70, 73, 73, 0.549), rgba(82, 81, 81, 0.5)),
               url('./image/drawerimg.jpg');
        background-repeat: no-repeat;
        background-size: cover;
    }
    h1, h2 , h3, h4, h5, h6{
        font-family: Roboto,Helvetica,Arial,sans-serif!important;
    }
    #core-view{
        padding-bottom: 50px;
    }
</style>
