<template>
  <v-form>
    <slot />
    <v-text-field
      v-model="userObj.username"
      :counter="10"
      label="Username"
      required
    ></v-text-field>
    <v-text-field
      v-model="userObj.email"
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
      v-model="passwordConfirmation"
      label="Confirm Password"
      required
    ></v-text-field>
    <v-btn class="mr-4" @click.prevent="submit">submit</v-btn>
    <v-btn >Cancel</v-btn>
    <router-link :to="{ name: 'users_path' }" class="btn btn-default pull-left">Back</router-link>
  </v-form>
</template>

<script>
  export default {
    props: {
      userObj: Object,
    },
    data: () => ({
      show1: false,
      password: '',
      passwordConfirmation: '',
      rules: {
        required: value => !!value || 'Required.',
        min: v => v.length >= 8 || 'Min 8 characters',
      },
    }),
    methods: {
      submit () {
        this.$emit('create', {
          username: this.userObj.username,
          email: this.userObj.email,
          password: this.password,
          password_confirmation: this.passwordConfirmation
        });
      },
    },
    created() {
      console.log(this.userObj);
    }
  }
</script>