<template>
<layout>
<div class="container">
        <p>{{ selected }}</p>
    <div class="row">
        <div class="col-sm-3">
                <v-img :src="require('src/components/images/weather.svg')"
                max-width="200"
                max-height="200">
                </v-img>
                <v-checkbox v-model="selected" label="Weather" value="weather"></v-checkbox>
        </div>
        <div class="col-sm-3">
                <v-img :src="require('src/components/images/news.svg')"
                max-width="200"
                max-height="200">
                </v-img>
                <v-checkbox v-model="selected" label="News" value="news"></v-checkbox>
        </div>
        <div class="col-sm-3">
                <v-img :src="require('src/components/images/map.svg')"
                max-width="200"
                max-height="200">
                </v-img>
                <v-checkbox v-model="selected" label="Map" value="map"></v-checkbox>
        </div>
        <div class="col-sm-3">
                <v-img :src="require('src/components/images/currencyexc.svg')"
                max-width="200"
                max-height="200">
                </v-img>
                <v-checkbox v-model="selected" label="Currency Exchange" value="currencyexc"></v-checkbox>
        </div>
    </div>
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
          selected: [],
        }
      },
    }
  </script>
  <style scoped>
      .v-icon{
          font-size: 30px !important;
      }
      .container{
          padding: 40px;
      }
      .col-sm-3{
          padding: 5px !important;
      }
  </style>