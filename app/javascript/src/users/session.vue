<template>
    <layout>
        <div class='col-xs-12'>
            <v-toolbar color="primary" dark flat>
                <v-toolbar-title><strong>Login</strong></v-toolbar-title>
            </v-toolbar>
            <div id="errors" v-if="error">{{ error }}</div>
            <v-form method="post" @submit.prevent="signin">
                <v-text-field :counter="10" label="Username" required v-model="username"></v-text-field>
                <v-text-field :type="'password'" label="Password" required v-model="password"></v-text-field>
                <div class="field">
                    <v-btn class="mr-4" type="submit">Submit</v-btn>
                </div>
            </v-form>
        </div>
    </layout>
</template>  
<script>
import Layout from '../shared/centred_layout.vue'
export default {
    name: 'Signin',
    components: {
        'layout' : Layout
    },
    data: function() {
        return {
            username: '',
            password: '',
            error: ''
        }
    },
    created () {
        this.checkSignedIn()
    },
    updated () {
        this.checkSignedIn()
    },
    methods: {
        signin () {
            this.$http.plain.post('/signin', { username: this.username, password: this.password })
            .then(response => this.signinSuccessful(response))
            .catch(error => this.signinFailed(error))
        },
        signinSuccessful (response) {
            if (!response.data.csrf) {
                this.signinFailed(response)
                return
            }
            this.$store.commit('setSession', { csrf: response.data.csrf, access: response.data.access })
            this.error = ''
            this.$router.replace('/home')
        },
        signinFailed (error) {
            this.error = (error.response && error.response.data && error.response.data.error) || ''
            this.$store.commit('unsetSession')
        },
        checkSignedIn () {
            if (this.$store.state.signedIn) {
                this.$router.replace('/home')
            }
        }
    }
}
</script>

<style>
  #errors{
    color: rgb(230, 36, 36);
  }
</style>