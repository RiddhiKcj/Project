<template>
  <layout>
    <v-form v-on:submit.prevent="create" accept-charset="UTF-8" class="form">
        <v-toolbar
        color="white"
        dark
        flat
    >
      <v-toolbar-title>Edit</v-toolbar-title></v-toolbar>
        <form-user></form-user>
      </v-form>
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
    },
  }
  </script>
  