<template>
    <v-tab-item v-if="SevenDaysData">
            <v-card flat color="basil">
                <div>
                    <div v-for="(val,key) in weatherData">
                        <div v-if="key === 'daily'">
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
                                        <td><v-img :src="require('../../../../../assets/images/' + obj.icon + '.svg')" class="row-img"></v-img></td>
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
            </v-card>
        </v-tab-item>
</template>
<script>
    export default{
        props: ['weatherData', 'SevenDaysData'],
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
        }
    }
</script>