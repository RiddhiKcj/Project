<template>
    <div>
        <v-navigation-drawer
        v-model="drawer"
        app
        clipped
        >
        <v-list dense>
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
        </v-list>
        </v-navigation-drawer>    
        
        <v-app-bar
        app
        clipped-left
        >
        <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
        <v-toolbar-title>Welcome {{currentUser}}</v-toolbar-title>
        </v-app-bar>
        <v-content>     
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
            console.log(this.user_id);
            return this.$store.state.user.username;
        },
    },
    methods: {
        navigateHome() {
            this.$router.push({path: '/'});
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
            delete localStorage.signedIn
            this.$router.replace('/')
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
</style>
