<template>
  <div>
  <h1>Hello world</h1>
  <v-app id="app" dark>
    <h1>Hello Vuetify</h1>
    <v-btn color="success">Vuetify Button</v-btn>
  </v-app>
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
