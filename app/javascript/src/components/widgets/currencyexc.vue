<template>
    <layout>
      <div class="container">
          <h3> {{ currencyexcData.source }} Rates</h3>
        <v-row justify="center">
            <v-simple-table dark fixed-header height="460px">
                <thead>
                    <tr>
                        <th>Currency</th>
                        <th>Rate</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(obj,key) in currencyexcData.quotes">
                        <td>{{ key }}</td>
                        <td>{{ obj }}</td>
                    </tr>
                </tbody>
            </v-simple-table>
        </v-row>
      </div>
    </layout>
  </template>
    <script>  
    export default{
      data() {
        return{
            currencyexcData:{}
        }
      },
      created() {
        console.log('reached currencyexcData');
        var self = this;
        $.ajax({
          url: '/api/widgets/currencyexc',
          dataType: "json", 
          type: "GET",
          success: function (data) {
            self.currencyexcData = data.currencyexcData;    
          }
        });
      }
    }
    </script>
    <style scoped>
      h3{
        text-align: center;
      }
      .v-data-table td, .v-data-table th{
          padding: 5px;
      }
    </style>