<template>
        <form method="post" action="/users/sign_in">
          <input type="hidden" name="authenticity_token" :value="csrf">
          <input type="hidden" name="commit" :value="commit">
          <div class="field">
            <label class="label">Username</label>
            <input type="text" class="input" name="username" v-model="user.username">
          </div>
      
          <div class="field">
            <label class="label">Password</label>
            <input type="password" class="input" name="password" v-model="user.password">
          </div>
      
          <div class="field">
            <button type="submit"  @click.prevent="submit">Submit</button>
          </div>
        </form>
      </template>
      
<script>
export default {
  data: function() {
    return ({
      csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
      user: {
      username: '',
      password: '',
      },
      commit: 'login',
    })
  },
  methods: {
    submit () {
      var self = this;
      console.log(self.user);
      $.ajax({
        url: '/users/sign_in',
        dataType: "json", 
        type: "POST",
        data: JSON.stringify({
          user: {
            username: self.user.username,
            password: self.user.password
          },
          commit: self.commit,
        }),
        contentType: "application/json",
        success: function (data) {
          console.log(data);
          self.$router.push({path: '/'});
        }
      });
    }, 
  }
}
</script>

<style scoped>
</style>