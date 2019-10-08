<template>
  <layout>
    <div class="container"> 
      <v-row justify="center">
        <div v-if="selectedWidgets.length === 0">Your Dashboard is empty :(</div>
        <div v-for="api in selectedWidgets" class="col-sm-3">
          <v-btn icon @click="$router.push('/api/' + api )">
            <v-img :src="require('src/components/images/' + api + '.png')"
              max-width="100"
              max-height="100">
              </v-img>
          </v-btn>    
        </div>
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
  .v-btn__content{
    background: brown !important;
    padding: 5px;
  }
  .col-sm-3{
    padding: none;
  }
</style>
