<template>
  <layout>
    <div class="container"> 
      <div v-if="selectedWidgets.length === 0">Your Dashboard is empty :(</div>
      <v-row class="mx-12 my-auto" justify="center" no-gutters>
        <v-col v-for="api in selectedWidgets" :key="api">
          <v-btn icon @click="$router.push('/api/' + api )" width="fit-content" height="fit-content">
          <v-card class="pa=2" outlined height="100" width="100">
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
    }
  }
</script>
<style scoped>
  .v-btn{
    display: inherit !important;
  }
</style>
