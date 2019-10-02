<template>  
  <v-app id="inspire">
      <v-card color="black">
        <v-card-title class="text-center justify-center py-6">
          <h1 class="font-weight-bold display-1 basil--text">WIDGETS APPLICATION</h1>
        </v-card-title>
    
        <v-tabs
          v-model="tab"
          background-color="transparent"
          color="green"
          grow
        >
          <v-tab>
           LOGIN
          </v-tab>
          <v-tab>
            SIGNUP
          </v-tab>
        </v-tabs>
    
      </v-card>
    </v-app>
</template>
    
<script>

export default {

  created () {
      this.$vuetify.theme.dark = true
    },
}
</script>
<style scoped>
  .basil {
  background-color: #FFFBE6 !important;
  }
  .basil--text {
  color: white !important;
  }
  .v-tab{
    color: white !important;
  }
  .v-tab--active{
    color: green !important;
  }
</style>