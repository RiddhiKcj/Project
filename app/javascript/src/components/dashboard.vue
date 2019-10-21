<template>
  <layout>
    <div class="container pt-12"> 
      <div v-if="selectedWidgets.length === 0">Your Dashboard is empty :(</div>
      <v-row no-gutters class="mx-12 my-auto" justify="center" >
        <v-col v-for="api in selectedWidgets" :key="api" cols="2">
          <v-btn icon @click="$router.push('/api/' + api )" width="fit-content" height="fit-content">
          <v-card class="pa=8" elevation="24" height="100" width="100">
            <v-img :src="require('src/components/images/' + api + '.png')"
              max-width="100"
              max-height="100">
            </v-img>
          </v-card>
        </v-btn>
        </v-col>
      </v-row>
  </div>
  </layout>
</template>
<script>

  export default {
    data () {
      return {
        ex4: ['indigo', 'primary', 'secondary', 'success', 'info', 'warning', 'error', 'red darken-3', 'indigo darken-3', 'orange darken-3'],
      }
    },
    computed: {
      selectedWidgets(){
        this.selected = this.$store.state.selectedWidgets
        return this.selected
      }
    },
    created() {
      if (this.$store.state.signedIn) {
        this.selected = this.$store.state.selectedWidgets
      }
      else{
        this.$router.replace('/')
      }
    }
  }
</script>
<style scoped>
  .v-btn{
    display: inherit !important;
    margin: 0 !important;
    padding: 0 !important;
  }
</style>
