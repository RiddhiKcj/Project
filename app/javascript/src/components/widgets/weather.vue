<template>
  <div>
  <news></news>
  <div>{{weatherData}}</div>
  </div>
</template>

<script>
import News from './news';

export default{
  data() {
    return{
      weatherData:{}
    }
  },
  components: {
    news: News,
  },
  created() {
    console.log('reached weather');
    var self = this;
    $.ajax({
      url: '/api/weather',
      dataType: "json", 
      type: "GET",
      success: function (data) {
        console.log(data);
        self.weatherData = data;    
      }
    });
  }
}
</script>