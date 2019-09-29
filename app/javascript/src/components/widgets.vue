<template>
<layout>
<div class="container">
    <div class="row">
        <div v-for="api in widgets" class="col-sm-3">
                <v-img :src="require('src/components/images/' + api.name + '.svg')"
                max-width="100"
                max-height="100">
                </v-img>
                <v-checkbox v-model="selected" :label="api.name" :value="api.name"></v-checkbox>
        </div>
    </div>
    <div class="row">
        <v-btn outlined color="pink" @click="addWidgets">Add to dashboard</v-btn>
    </div>
</div>
</layout>
  </template>
  <script>
    export default {
    data () {
      return {
        selected: [],
      }
    },
    computed: {
        widgets(){
            return this.$store.state.widgets
        },
        userId(){
          return this.$store.state.user.id
        }
    },
    created () {
      this.selected = this.$store.state.selectedWidgets
    },
    methods: {
      addWidgets(){
        var self = this
        $.ajax({
          url: '/users/' + self.userId + '/myapis',
          dataType: "json", 
          type: "POST",
          data: JSON.stringify(self.selected),
          contentType: "application/json",
          success: function (data) {
            alert("Wizards Added Successfully")
            console.log(data);
            self.$store.dispatch('index');
          },
          error: function(data){
            console.log(data);
          }
        });
      },
    }
    }
  </script>
  <style scoped>
      .v-icon{
          font-size: 30px !important;
      }
      .container{
          padding: 50px;
      }
      .col-sm-3{
          padding: 5px !important;
      }
  </style>