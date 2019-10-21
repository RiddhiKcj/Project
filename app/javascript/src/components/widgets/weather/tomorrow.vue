<template>
    <v-tab-item v-if="Tomorrow">
        <v-card flat color="basil">
            <div>
                <div v-for="(val,key) in weatherData">
                    <div v-if="key === 'daily'">
                        <div v-for="(obj,key,index) in val.data.slice(1,2)">
                            <v-banner>
                                <v-avatar slot="icon" color="deep-purple accent-4" size="40">
                                    <v-icon icon="mdi-lock" color="white"> {{ iconsMapping[obj.icon]}} </v-icon>
                                </v-avatar>
                                {{ obj.summary }}
                                <div class="flex-grow-1"></div>
                                {{ convertIntoLocaleTime(obj.time) }}
                            </v-banner>
                            <v-container>
                                <v-row justify="space-around">
                                    <v-sheet  width="200" height="100" elevation="5">
                                        <span style="float:right; margin-right:40px;"><h4 >{{ obj.temperatureHigh }} &#730;F ~ {{ obj.temperatureLow }} &#730;F</h4></span>
                                    </v-sheet>
                                    <v-sheet  width="200" height="100" elevation="4" dark >
                                        <v-card>
                                            <ul class="list-group"><h6 >Precipitation</h6>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                Probability<span class="badge badge-secondary badge-pill">{{ obj.precipProbability }}</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                Intensity<span class="badge badge-secondary badge-pill">{{ obj.precipIntensity }}</span>
                                                </li>
                                            </ul>
                                        </v-card>
                                    </v-sheet>
                                    <v-sheet  width="200" height="100" elevation="5" dark >
                                        <v-card>
                                                <ul class="list-group"><h6>Wind</h6>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    Speed<span class="badge badge-secondary badge-pill">{{ obj.windSpeed }}mph</span>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    Bearing<span class="badge badge-secondary badge-pill">{{ obj.windBearing }}mph</span>
                                                    </li>
                                                </ul>
                                        </v-card>
                                    </v-sheet>
                                    <v-sheet  width="200" height="100" elevation="5" dark>
                                        <v-card>
                                            <ul class="list-group ">
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                Pressure<span class="badge badge-secondary badge-pill">{{ obj.pressure }}mbrs</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                Humidity<span class="badge badge-secondary badge-pill">{{ obj.humidity }}</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                Visibility<span class="badge badge-secondary badge-pill">{{ obj.visibility }}</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                DewPoint<span class="badge badge-secondary badge-pill">{{ obj.dewPoint }}</span>
                                                </li>
                                            </ul>
                                    </v-card>
                                    </v-sheet>
                                </v-row>
                            </v-container>
                        </div>
                    </div>          
                </div>
            </div>
        </v-card>
    </v-tab-item>
</template>
<script>
export default{
    props: ['weatherData', 'Tomorrow'],
    data() {
        return {
            days: ['Sun','Mon','Tue','Wed','Thurs','Fri','Sat'],
            months: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'],
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
        convertIntoLocaleTime(unixTimestamp){
            var date = new Date( unixTimestamp * 1000 ).toLocaleString()
            return date
        },
    }
}
</script>