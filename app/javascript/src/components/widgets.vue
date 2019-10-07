<template>
  <layout>
    <v-row justify="center">
      <v-dialog v-model="dialog" max-width="500">
        <v-card>  
          <v-card-title>
           <p>Whola! Wizards Added Successfully.</p>
          </v-card-title>
          <v-card-actions>
          <div class="flex-grow-1"></div>  
          <v-btn color="green darken-1" text @click="dialog = false">
            OK
          </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
            
    <div class="container">
      <div class="row">
          <div v-for="api in widgets" class="col-sm-3">
                  <v-img :src="require('src/components/images/' + api.name + '.png')"
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
          dialog: false
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
          url: '/api/users/' + self.userId + '/selectedwidgets',
          dataType: "json", 
          type: "POST",
          data: JSON.stringify(self.selected),
          contentType: "application/json",
          success: function (data) {
            console.log(data);
            self.$store.dispatch('index');
            self.dialog = true;
            self.$router.replace('/home');
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