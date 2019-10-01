<template>
    <div class='row'>
      <div class='col-xs-12'>
        <h1>Welcome to Widgets Application</h1>
        <p>Please login or sign up to continue</p>
      </div>
    </div>
  </template>
  
  <script>
  export default {
  
    methods: {
      activeOn: function(paths) {
        if(paths.includes(this.$route.name)) {
          return 'active';
        } else {
          return '';
        }
      }
    }
  }
  </script>
  