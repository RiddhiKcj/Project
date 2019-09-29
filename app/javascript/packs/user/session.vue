<template>
        <form method="post" action="/users/sign_in">
          <input type="hidden" name="authenticity_token" :value="csrf">
      
          <div class="field">
            <label class="label">Username</label>
            <input type="text" class="input" name="username">
          </div>
      
          <div class="field">
            <label class="label">Password</label>
            <input type="password" class="input" name="password">
          </div>
      
          <div class="field">
            <button type="submit">Submit</button>
          </div>
        </form>
      </template>
      
      <script>
      export default {
        data: function() {
          return ({
             csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          })
        },
      }
      </script>
      
      <style scoped>
      </style>