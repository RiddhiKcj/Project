<template>  
  <layout>
      <div class='col-xs-12'>
        <v-toolbar color="primary" dark flat>
        <v-toolbar-title><strong>Sign Up</strong></v-toolbar-title>
        </v-toolbar>
        <div id="errors" v-if="error">{{error}}</div>
        <v-form  @submit.prevent="signup">
          <v-text-field
            v-model="username"
            :counter="10"
            label="Username"
            required
          ></v-text-field>
          <v-text-field
            v-model="email"
            label="E-mail"
            required
          ></v-text-field>
          <v-text-field
            v-model="password"
            :append-icon="show1 ? 'visibility' : 'visibility_off'"
            :rules="[rules.required, rules.min]"
            :type="show1 ? 'text' : 'password'"
            label="Password"
            hint="At least 8 characters"
            counter
            @click:append="show1 = !show1">
          </v-text-field>
          <v-text-field
            v-model="password_confirmation"
            label="Confirm Password"
            required
          ></v-text-field>
          <v-btn class="mr-4" type="submit">submit</v-btn>
        </v-form>
      </div>
    </layout> 
  </template>
  
  <script>
  import Layout from '../shared/centred_layout.vue'

  export default {
    components: {
      'layout' : Layout
    },
    name: 'Signup',
    data: function() {
      return ({
       show1: false,
        username: '',
        email: '',
        password: '',
        password_confirmation: '',
        rules: {
        required: value => !!value || 'Required.',
          min: v => v.length >= 8 || 'Min 8 characters',
        },
       error: ''
    })
    },
    created () {
    this.checkSignedIn()
    },
    updated () {
      this.checkSignedIn()
    },
    methods: {
      signup () {
      this.$http.plain.post('/signup', { username: this.username, email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
      },
      signupSuccessful (response) {
        if (!response.data.csrf) {
          this.signupFailed(response)
          return
        }
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.error = ''
        this.$router.replace('/home')
      },
      signupFailed (error) {
        this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
        delete localStorage.csrf
        delete localStorage.signedIn
      },
      checkSignedIn () {
        if (localStorage.signedIn) {
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