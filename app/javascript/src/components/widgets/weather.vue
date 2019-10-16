<template>
    <div id="inspire">
        <v-toolbar dark>
            <v-btn icon background-color="inherit" class="v-app-bar__nav-icon" @click="navigateHome" ><v-icon>mdi-home</v-icon></v-btn>
            <v-toolbar-title><v-btn icon @click="refreshPage"><v-icon>mdi-weather-sunny</v-icon></v-btn>&nbsp;&nbsp;WEATHER API</v-toolbar-title>
            <div class="flex-grow-1"></div>
            <v-toolbar-items>
                <v-text-field placeholder="Search by City" color="smokewhite" signle-line rounded solo v-model="city" class="ma-3"></v-text-field>
                <v-btn icon>
                    <v-icon v-show="city" @click="searchByCity(undefined)">mdi-magnify</v-icon>
                </v-btn>
                <v-btn icon>
                    <v-icon>mdi-earth</v-icon>
                    {{ location.country }}
                </v-btn>
            </v-toolbar-items>
        </v-toolbar>
        <v-toolbar dense dark prominent src="https://cdn.vuetifyjs.com/images/backgrounds/vbanner.jpg">
            <v-toolbar-title><v-icon>mdi-city</v-icon> {{ location.city }}  {{location.region}} {{location.state}}</v-toolbar-title>
            <div class="flex-grow-1"></div>

            <v-toolbar-items>
                <v-menu :disabled="menuDisabled" close-on-click close-on-content-click bottom left>
                    <template v-slot:activator="{ on }">
                        <v-btn color="#479cfc" v-on="on">Day </v-btn>
                    </template>
                    <v-list>
                    <v-list-item-group color="primary">
                        <v-list-item @click="showToday" >
                            <v-list-item-title>Today</v-list-item-title>
                        </v-list-item>
                        <v-list-item @click="showTomorrow" >
                            <v-list-item-title>Tomorrow</v-list-item-title>
                        </v-list-item>
                        <v-list-item @click="showNext3" >
                            <v-list-item-title>3 Days</v-list-item-title>
                        </v-list-item>
                        <v-list-item @click="showNext7" >
                            <v-list-item-title>7 Days</v-list-item-title>
                        </v-list-item>
                    </v-list-item-group>
                    </v-list>
                </v-menu>
                <v-btn color="primary" @click="date_picker_dialog=true">Date</v-btn>
                <v-row justify="center">
                    <v-dialog v-model="date_picker_dialog" persistent max-width="600px">
                      <v-card>
                        <v-card-title>
                          <span class="headline">Select Date</span>
                        </v-card-title>
                        <v-card-text>
                          <v-container>
                            <v-row justify="center">
                                <v-date-picker v-model="datepicker"></v-date-picker>
                            </v-row></v-container>
                        </v-card-text>
                        <v-card-actions>
                         <v-spacer></v-spacer>
                         <v-btn color="blue darken-1" text @click="selectTime">Next</v-btn>
                         <v-btn color="blue darken-1" text @click="date_picker_dialog=false">Cancel</v-btn>
                        </v-card-actions>
                        </v-card>
                    </v-dialog>
                    <v-dialog v-model="time_picker_dialog" persistent max-width="600px">
                        <v-card>
                            <v-card-title>
                            <span class="headline">Select Time</span>
                            </v-card-title>
                            <v-card-text>
                            <v-container>
                                <v-row justify="center">
                                <v-time-picker v-model="timepicker"></v-time-picker>
                                </v-row></v-container>
                            </v-card-text>
                            <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="blue darken-1" text @click="sendUnixTime">Go</v-btn>
                            <v-btn color="blue darken-1" text @click="time_picker_dialog=false">Cancel</v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                </v-row>
            </v-toolbar-items>
        </v-toolbar>
        
        <v-tabs fixed-tabs background-color="indigo" dark v-show="options" v-model="tab">
            <v-tab>Currently</v-tab>
            <v-tab>Hourly</v-tab>
        </v-tabs>
        <v-tabs-items v-model="tab">
            <v-tab-item v-if="Today">
              <v-card flat color="basil">
                <div>
                    <div v-for="(val,key) in weatherData">
                        <div v-if="key === 'currently'">
                            <v-banner>
                                <v-avatar slot="icon" color="deep-purple accent-4" size="40">
                                    <v-icon icon="mdi-lock" color="white"> {{ iconsMapping[val.icon]}} </v-icon>
                                </v-avatar>
                                {{ val.summary }}
                                <div class="flex-grow-1"></div>
                                {{ convertIntoLocaleTime(val.time) }}
                            </v-banner>
                            <v-container>
                                <v-row justify="space-around">
                                    <v-sheet  width="180" height="100" elevation="5">
                                        <span style="float:right; margin-right:40px;"><h4 >{{ val.temperature }} &#730;F</h4><br />
                                        <h6>Feels like &nbsp;{{ val.apparentTemperature }} &#730;F</h6></span>
                                    </v-sheet>
                                    <v-sheet  width="200" height="100" elevation="4" dark >
                                        <v-card>
                                            <ul class="list-group"><h6 >Precipitation</h6>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                Probability<span class="badge badge-secondary badge-pill">{{ val.precipProbability }}</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                Intensity<span class="badge badge-secondary badge-pill">{{ val.precipIntensity }}</span>
                                                </li>
                                            </ul>
                                        </v-card>
                                    </v-sheet>
                                    <v-sheet  width="200" height="100" elevation="5" dark >
                                        <v-card>
                                                <ul class="list-group"><h6>Wind</h6>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    Speed<span class="badge badge-secondary badge-pill">{{ val.windSpeed }}mph</span>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    Bearing<span class="badge badge-secondary badge-pill">{{ val.windBearing }}mph</span>
                                                    </li>
                                                </ul>
                                        </v-card>
                                    </v-sheet>
                                    <v-sheet  width="200" height="100" elevation="5" dark>
                                        <v-card>
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
                                        </v-card>
                                    </v-sheet>
                                </v-row>
                            </v-container>
                        </div>          
                    </div>
                </div>
              </v-card>
            </v-tab-item>
            <v-tab-item v-if="Today">
                <v-card flat color="basil">
                  <div>
                        <ul>
                            <div v-for="(val,key) in weatherData">
                            <div v-if="key === 'hourly'">
                                <v-banner>
                                    <v-avatar slot="icon" color="deep-purple accent-4" size="40">
                                        <v-icon icon="mdi-lock" color="white"> {{ iconsMapping[val.icon]}} </v-icon>
                                    </v-avatar>
                                    {{ val.summary }}
                                </v-banner>
                                <div class="container">
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
                            </div>
                        </ul>
                  </div>
                </v-card>
            </v-tab-item>
            <tomorrow :weatherData="weatherData" :Tomorrow="Tomorrow"></tomorrow>
            <three-days-data :weatherData="weatherData" :ThreeDaysData="ThreeDaysData"></three-days-data>
            <seven-days-data :weatherData="weatherData" :SevenDaysData="SevenDaysData"></seven-days-data>
        </v-tabs-items>
    </div>
</template>
<script>
    import SevenDaysData from './weather/sevendays.vue';
    import ThreeDaysData from './weather/threedays.vue';
    import Tomorrow from './weather/tomorrow.vue';
    export default{
      components: {
        'seven-days-data' : SevenDaysData,
        'three-days-data' : ThreeDaysData,
        'tomorrow' : Tomorrow
      },
      data() {
        return{
          weatherData:{},
          location: {},
          days: ['Sun','Mon','Tue','Wed','Thurs','Fri','Sat'],
          months: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'],
          options: true,
          items: ['Today', 'Tomorrow', 'Next 3 Days', 'Next 7 days'],
          menuDisabled: false,
          datepicker: new Date().toISOString().substr(0, 10),
          timepicker: null,
          date_picker_dialog: false,
          time_picker_dialog: false,
          tab: null,
          city: '',
          SevenDaysData : false,
          ThreeDaysData: false,
          Tomorrow: false,
          Today: true,
          currentDate: '',
          iconsMapping: {
            'clear-day' : 'mdi-weather-sunny',
            'clear-night' : 'mdi-weather-night',
            'rain' : 'mdi-weather-pouring',
            'snow' : 'mdi-weather-snowy',
            'sleet' : 'mdi-weather-snowy-rainy',
            'wind' : 'mdi-weather-windy',
            'fog' : 'mdi-weather-fog  ',
            'cloudy' : 'mdi-weather-cloudy',
            'partly-cloudy-day' : 'mdi-weather-partlycloudy',
            'partly-cloudy-night' : 'mdi-weather-cloudy'
          },
        }
      },
      methods: {
        convertTime(unixTimestamp) {
          var date = new Date( unixTimestamp * 1000 )
          return date
        },
        convertIntoLocaleTime(unixTimestamp){
            var date = new Date( unixTimestamp * 1000 ).toLocaleString()
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
        },
        navigateHome() {
            this.$router.push({path: '/'});
        },
        searchByCity(unixtime) {
            if(unixtime === undefined){
                if(this.city === '' || this.city === undefined){
                    return;
                }
                else{
                    var data = { city: this.city}
                }
            }
            else{
                if(this.city === '' || this.city === undefined){
                    var data = {
                        city: this.location.city,
                        unixtime: unixtime
                    }
                }
                else{
                    var data = {
                        city: this.city,
                        unixtime: unixtime
                    }
                    this.resetMenu
                }
            }
            var self = this;
            $.ajax({
            beforeSend: function(xhr) {
                        xhr.setRequestHeader('X-CSRF-TOKEN', localStorage.csrf);
                        xhr.setRequestHeader('Authorization', 'Bearer ' + localStorage.access);
                    },
            url: '/api/widgets/weather',
            dataType: "json", 
            type: "POST",
            data: data,
            success: function (data) {
                self.weatherData = data.weatherData
                self.location = data.location 
                self.currentDate = self.weatherData.currently.time
            }
            });
        },
        showToday() {
            this.SevenDaysData = false;
            this.ThreeDaysData = false;
            this.Tomorrow = false;
            this.Today = true;
            this.options = true;
            
        },
        showTomorrow(){
            this.SevenDaysData = false;
            this.ThreeDaysData = false;
            this.Tomorrow = true;
            this.Today = false;
            this.options = false;
        },
        showNext3(){
            this.SevenDaysData = false;
            this.ThreeDaysData = true;
            this.Tomorrow = false;
            this.Today = false;
            this.options = false;
        },
        showNext7(){
            this.SevenDaysData = true;
            this.ThreeDaysData = false;
            this.Tomorrow = false;
            this.Today = false;
            this.options = false;
        },
        selectTime() {
            this.date_picker_dialog = false;
            this.time_picker_dialog = true;
        },
        sendUnixTime() {
            this.time_picker_dialog = false;
            var unixtime = Date.parse(this.datepicker + ' ' + this.timepicker)/1000
            this.searchByCity(unixtime)
        },
        resetMenu(){
            this.SevenDaysData = false;
            this.ThreeDaysData = false;
            this.Tomorrow = false;
            this.Today = true;
            this.options = true;
            this.menuDisabled = true
        },
        refreshPage() {
            window.location.href = '/api/weather';
        }
      },
      created() {
        this.$vuetify.theme.dark = false
        var self = this;
        $.ajax({
          beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-TOKEN', localStorage.csrf);
                    xhr.setRequestHeader('Authorization', 'Bearer ' + localStorage.access);
                  },
          url: '/api/widgets/weather',
          dataType: "json", 
          type: "GET",
          success: function (data) {
            self.weatherData = data.weatherData
            self.location = data.location  
            self.options = true
            self.currentDate = self.weatherData.currently.time
            self.menuDisabled = false
          },
          error: function (jqXHR, status, err) {
            if (jqXHR.status === 401) {
                localStorage.clear();
                self.$router.push('/');
            }
           },
        });
      }
    }
</script>
<style>
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
        padding: 0;
      }
      .v-toolbar__items.v-input__slot{
        width: 300px;
        margin-top:5px;
      }
    .v-toolbar__items.v-btn{
        color: inherit !important;
    }
    .list-group-item{
        color: slategrey;
    }
</style>