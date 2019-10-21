<template>
  <layout>
      <div class="container">
      <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus lobortis justo, vitae congue leo maximus nec. Duis vitae ornare dolor. Integer ut magna diam. Vestibulum mollis massa eu ante fringilla vestibulum. Mauris id dui vestibulum, aliquam velit ac, congue mi. Suspendisse vulputate facilisis eros, id aliquet risus convallis id. Vivamus pretium leo erat, nec congue nisl tempor vitae. Vestibulum at sem et felis tincidunt congue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus ut rhoncus dolor. Suspendisse potenti. Nam ut ligula tempor, hendrerit magna et, aliquet justo. Mauris lacus tortor, dapibus eu mollis at, pretium id erat.
        Suspendisse elementum, odio ac tempus vestibulum, purus dui ultrices tellus, vitae facilisis leo augue in libero. Cras vehicula ante in purus rutrum ullamcorper. Donec suscipit sodales velit vehicula eleifend. Quisque velit massa, rhoncus nec consequat ac, placerat vel justo. Vivamus iaculis sapien lacus, sit amet sodales velit commodo sed. Duis iaculis consectetur purus, ac semper ligula fringilla nec. Maecenas consequat elit vitae aliquet ultrices. Aenean pellentesque volutpat dapibus. In nec mauris auctor, sodales nisi id, vulputate justo. Nam molestie, neque eget varius porta, purus ipsum luctus mauris, et consectetur enim massa ac dolor. Morbi suscipit ante eget odio molestie euismod. Nullam lacus elit, accumsan ac lacinia a, volutpat non turpis. Maecenas venenatis eros eu urna sagittis interdum. Nulla facilisi. Suspendisse ultrices elit non quam pulvinar, ac condimentum odio finibus.
      </p>
    </div>   
  </layout>   
</template>
<script>
import Layout from '../shared/layout.vue'
  export default {
    components: {
    Layout
    },
    computed: {
      userData(){
        return this.$store.state.user;
      }
    },
    created() {
      if (this.$store.state.signedIn) {
        this.$store.dispatch('index')
      }
      else{
        this.$router.replace('/')
      }
    }
  }
</script>