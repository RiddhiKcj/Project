<template>
  <v-app id="inspire">
    
  </v-app>
</template>

<script>
  export default {
    props: {
      source: String,
    },
    data: () => ({
      drawer: null,
    }),
    methods: {
      navigateDashboard() {
        this.$router.push({path: '/dashboard'});
      }
    },
    created () {
      this.$vuetify.theme.dark = true
    },
  }
</script>