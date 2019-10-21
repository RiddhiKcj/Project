<template>
    <layout>
        <div class="container">
            <h3> {{ currencyexcData.source }} Rates</h3>
            <v-row justify="center">
                <v-simple-table dark fixed-header height="400px">
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
    if (!this.$store.state.signedIn) {
        this.$router.replace('/')
    }
    var self = this;
    $.ajax({
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-TOKEN', self.$store.state.csrf);
            xhr.setRequestHeader('Authorization', 'Bearer ' + self.$store.state.access);
        },
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
  .v-data-table{
    width: 300px;
    padding: 10px; 
  }
</style>