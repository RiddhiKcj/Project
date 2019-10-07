<template>
  <layout>
    <div class="container">
      <v-row justify="center">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="false">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <!-- carousel-1 -->
            <div class="carousel-inner">
              <div class="carousel-item active">  
                <div class="jumbotron">
                  <h3 style="color:#ffffff;">{{ address }}</h3><hr/>
                  <div v-for="(val,key) in weatherData">
                    <div v-if="key === 'currently'">
                      <span style="float:right; margin-right:40px;"><h4 style="color:#f8f8f8;">{{ val.temperature }} &#730;F</h4>
                      <h6 style="color:#f8f8f8;">Feels like &nbsp;{{ val.apparentTemperature }} &#730;F</h6></span>
                      <h6 style="color:#f8f8f8;">{{ convertTime(val.time) }}</h6><br />
                      <span><v-img :src="require('../../../../assets/images/' + val.icon + '.svg')" class="weather-img"></v-img></span>
                      <h5 style="color:#f8f8f8;"><b>{{ val.summary }}</b></h5>
                      <br />                 
                      <div class="card col-sm-4" style="width: 15rem;">
                          <div class="card-body">
                              <ul class="list-group"><h6 style="color:#e4e4e4">Precipitation</h6>
                                  <li class="list-group-item d-flex justify-content-between align-items-center">
                                  Probability<span class="badge badge-secondary badge-pill">{{ val.precipProbability }}</span>
                                  </li>
                                  <li class="list-group-item d-flex justify-content-between align-items-center">
                                  Intensity<span class="badge badge-secondary badge-pill">{{ val.precipIntensity }}</span>
                                  </li>
                              </ul>
                          </div>
                      </div>
                      
                      <div class="card col-sm-4" style="width: 15rem;">
                          <div class="card-body">
                              <ul class="list-group"><h6 style="color:#e4e4e4">Wind</h6>
                                  <li class="list-group-item d-flex justify-content-between align-items-center">
                                  Speed<span class="badge badge-secondary badge-pill">{{ val.windSpeed }}mph</span>
                                  </li>
                                  <li class="list-group-item d-flex justify-content-between align-items-center">
                                  Bearing<span class="badge badge-secondary badge-pill">{{ val.windBearing }}mph</span>
                                  </li>
                              </ul>
                          </div>
                      </div>


                      <div class=" card col-sm-4" style="width: 18rem;">
                          <div class="card-body">
                          <ul class="list-group ">
                              <li class="list-group-item d-flex justify-content-between align-items-center">
                              Pressure<span class="badge badge-secondary badge-pill">{{ val.pressure }}mbrs</span>
                              </li>
                              <li class="list-group-item d-flex justify-content-between align-items-center">
                              Humidity<span class="badge badge-secondary badge-pill">{{ val.humidity }}</span>
                              </li>
                              <li class="list-group-item d-flex justify-content-between align-items-center">
                              Visibility<span class="badge badge-secondary badge-pill">{{ val.visibility }}</span>
                              </li>
                              <li class="list-group-item d-flex justify-content-between align-items-center">
                              DewPoint<span class="badge badge-secondary badge-pill">{{ val.dewPoint }}</span>
                              </li>
                          </ul>
                          </div>
                      </div>
                    </div>          
                  </div>
                </div>
              </div>
              <!-- carousel-2 -->
              <div class="carousel-item">
                <div class="jumbotron">
                  <h3 style="color:#f8f8f8;">Hourly Report</h3>
                  <ul>
                    <div v-for="(val,key) in weatherData">
                      <div v-if="key === 'hourly'">
                          <span><v-img :src="require('../../../../assets/images/' + val.icon + '.svg')" class="weather-img"></v-img></span>
                        <h5 style="color:#f8f8f8;"><strong>{{ val.summary }}</strong></h5>
                        <v-simple-table dark fixed-header height="350px">
                          <thead>
                            <tr>
                              <th>Time</th>
                              <th>Weather</th>
                              <th>Summary</th>
                              <th>Precipitation</th>
                              <th>Temperature</th>
                            </tr>
                          </thead>
                          <tbody>
                              <tr v-for="(obj,key,index) in val.data.slice(0,8) ">
                                  <td>{{ convertTime(obj.time).getHours()  }} : 00</td>
                                  <td><v-img :src="require('../../../../assets/images/' + obj.icon + '.svg')" class="row-img"></v-img></td>
                                  <td><b>{{ obj.summary  }}</b></td>
                                  <td>{{ obj.precipProbability * 100 }} % </td>
                                  <td>{{ obj.temperature  }} &#730;F</td>
                              </tr>
                          </tbody>
                        </v-simple-table>
                      </div>
                    </div>
                  </ul>
                </div>
              </div>
  
  
              <!-- carousel-3 -->
              <div class="carousel-item">
                <div class="jumbotron">
                  <h3 style="color:#f8f8f8;">Daily Report</h3>
                  <div v-for="(val,key) in weatherData">
                    <div v-if="key === 'daily'">
                      <v-img :src="require('../../../../assets/images/' + val.icon + '.svg')" class="weather-img"></v-img>

                      <h5 style="color:#f8f8f8;"><strong>{{ val.summary }}</strong></h5>
                      <v-simple-table dark fixed-header height="350px">
                        <thead>
                          <tr>
                            <th>Day</th>                                   
                            <th>Weather</th>
                            <th>Summary</th>
                            <th>Precipitation</th>
                            <th>Temperature</th>
                            <th>Sunrise</th>
                            <th>Sunset</th>
                          </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(obj,key,index) in val.data">
                              <td scope="row">{{ findDay(obj.time) }},{{ findMonth(obj.time) }} {{ convertTime(obj.time).getDate() }}</td>
                              <td><v-img :src="require('../../../../assets/images/' + obj.icon + '.svg')" class="row-img"></v-img></td>
                              <td>{{ obj.summary}}</td>
                              <td>{{ obj.precipProbability * 100}}%</td>
                              <td>{{ obj.temperatureHigh }}&#730;F ~ {{ obj.temperatureLow }}&#730;F</td>
                              <td>{{convertTime(obj.sunriseTime).getHours()}}: {{convertTime(obj.sunriseTime).getMinutes() }}</td>
                              <td>{{convertTime(obj.sunsetTime).getHours() }}</td>
                            </tr>
                        </tbody>
                      </v-simple-table>
                    </div>
                  </div>
                </div>
              </div>
              
              <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
              </a>
              <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
              </a>             
            </div>
        </div>
      </v-row>
    </div>
  </layout>
</template>

<script>
export default{
  data() {
    return{
      weatherData:{},
      address: '',
      days: ['Sun','Mon','Tue','Wed','Thurs','Fri','Sat'],
      months: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec']
    }
  },
  methods: {
    convertTime(unixTimestamp) {
      var date = new Date( unixTimestamp * 1000 )
      return date
    },
    findDay(unixTimestamp){
      var date = new Date( unixTimestamp * 1000 )
      var index = date.getDay()
      return this.days[index]
    },
    findMonth(unixTimestamp){
      var date = new Date( unixTimestamp * 1000 )
      var index = date.getMonth()
      return this.months[index]
    }
  },
  created() {
    console.log('reached weather');
    var self = this;
    $.ajax({
      url: '/api/widgets/weather',
      dataType: "json", 
      type: "GET",
      success: function (data) {
        console.log(data);
        self.weatherData = data.weatherData
        self.address = data.address  
      }
    });
  }
}
</script>
<style scoped>
  .row-img{
    width: 90px;
    height: 90px;
  }
  .weather-img{
    width: 120px;
    height: 120px;
  }
  .card li{
    color: rgb(88, 85, 85) !important;
  }
  h3{
    text-align: center;
    padding: none;
  }
  hr{
    background: #e4e4e4;
  }
  .col-sm-4{
    padding-left: 0px;
    padding-right: 0px;
  }
</style>