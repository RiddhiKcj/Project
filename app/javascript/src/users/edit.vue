<template>
  <layout>
    <v-toolbar color="primary" dark flat>
    <v-toolbar-title>Edit</v-toolbar-title></v-toolbar>
    <p id="errors" v-for="(item,key) in error" v-bind:innerhtml="error">{{key}} : <span v-for="err in item">{{err}}</span></p>
    <v-form v-on:submit.prevent="create" accept-charset="UTF-8" class="form">
      <input type='hidden' name='_method' value='put'>
      <v-text-field v-model="userObj.username" :counter="10" label="Username" required="true">
      </v-text-field>
      <v-text-field v-model="userObj.email" label="E-mail" required="true" ></v-text-field>
      <v-text-field  v-model="userObj.password" type='password' label="Password" hint="At least 8 characters" counter>
      </v-text-field>
      <v-btn class="mr-4" @click.prevent="updateUser">Update</v-btn>
      <v-btn class="mr-4" @click="navigateToRoot">Cancel</v-btn>
      </v-form>
    </layout>
  </template>
  <script>
  import Layout from '../shared/centred_layout.vue'
  export default {
    components: {
      'layout' : Layout
    },
  
    data: function() {
      return ({
       csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
       userObj: {
        username: this.$store.state.user.username,
        email: this.$store.state.user.email,
        password: ''
       },
        user_id: null,
       error: {}
    })
    },
    methods: {
      updateUser() {
        var self = this;
        self.user_id = self.$route.params.id;
        $.ajax({
          url: '/users/'+self.user_id,
          dataType: "json", 
          type: "PUT",
          data: self.userObj,
          success: function (data) {
            alert("Profile updated successfully")
            navigateToRoot;
            console.log(data);
            self.router.go({name: root_path})
          },
          error: function(data){
            if (data["responseJSON"]) {
              self.error = data["responseJSON"]["errors"];
            }
            console.log(data);
          }
        });
      },
      navigateToRoot() {
        this.$router.push({path: '/'});
      }
    },
    created() {
      this.username = this.$store.state.user.username
    }
  }
  </script>
  <style>
    #errors{
      color: rgb(230, 36, 36);
    }
  </style>