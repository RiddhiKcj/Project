<template>  
  <layout>
      <div class='col-xs-12'>
        <v-toolbar color="primary" dark flat>
        <v-toolbar-title><strong>Login</strong></v-toolbar-title>
        </v-toolbar>
        <p id="errors" v-for="(item,key) in error" v-bind:innerhtml="error">{{key}} : <span v-for="err in item">{{err}}</span></p>
        <form-user :userObj="userObj" @create="createUser">
            <input type="hidden" name="authenticity_token" :value="csrf">
        </form-user>
      </div>
    </layout> 
  </template>
  
  <script>
  import FormUser from './_form.vue';
  import Layout from '../shared/centred_layout.vue'

  export default {
    components: {
      'form-user': FormUser,
      'layout' : Layout
    },
  
    data: function() {
      return ({
       csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
       userObj: {
        username: '',
        email: '',
        password: '',
        password_confirmation: ''
       },
       error: {}
    })
    },
    methods: {
      createUser(userObj) {
        var self = this;
        console.log(userObj);
        $.ajax({
          url: '/users',
          dataType: "json", 
          type: "POST",
          data: JSON.stringify(userObj),
          contentType: "application/json",
          success: function (data) {
            console.log(data);
          },
          error: function(data){
            self.error = data["responseJSON"]["errors"];
            console.log(data);
          }
        });
      }
    }
  }
  </script>
  <style>
    #errors{
      color: rgb(230, 36, 36);
    }
  </style>