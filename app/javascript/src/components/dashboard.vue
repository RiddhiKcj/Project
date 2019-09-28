<template>
  <layout>
    <div>
      <v-card>
        <v-card-title>Weather</v-card-title>
        <v-card-text>
        </v-card-text>
        <v-card-actions>
            <v-checkbox
              v-model="ex4"
              label="indigo darken-3"
              color="indigo darken-3"
              value="weather"
              hide-details
            ></v-checkbox>
        </v-card-actions>
      </v-card>
      <v-card>
        <v-card-title>News</v-card-title>
        <v-card-text>
        </v-card-text>
        <v-card-actions>
            <v-checkbox
              v-model="ex4"
              label="secondary darken-3"
              color="secondary darken-3"
              value="news"
              hide-details
            ></v-checkbox>
        </v-card-actions>
      </v-card>
    </div>
  </layout>
</template>
<script>
import Layout from '../shared/layout.vue'
  export default {
    components: {
    Layout
    },
    data () {
      return {
        ex4: ['indigo', 'primary', 'secondary', 'success', 'info', 'warning', 'error', 'red darken-3', 'indigo darken-3', 'orange darken-3'],
      }
    },
  }
</script>
<style scoped>

</style>