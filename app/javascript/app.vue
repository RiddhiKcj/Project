<template>
  <div>
    <v-app id="app" dark>
      <v-content>
        <div>
          <router-view></router-view>
        </div>
      </v-content>
    </v-app>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
    }
  },
  created() {
  }
}
</script>
