<template>
    <v-container fluid >
        <v-row justify="center">
            <v-dialog color="black" v-model="showMovie" width="550" height="fit-content">
              <v-card>  
                <v-card-title style="background: transparent;">
                    <div class="flex-grow-1"></div> 
                    <v-btn icon @click="showMovie = false"><v-icon>mdi-close</v-icon></v-btn>
                </v-card-title>
                <v-card-text class="p-0">
                    <iframe width="550" height="345" :src="vdoPath">
                    </iframe>
                </v-card-text>
              </v-card>
            </v-dialog>
        </v-row>

        <v-toolbar fixed extended dark color="black" class="m-0 p-0">
                <v-toolbar-title><v-icon>mdi-movie</v-icon>&nbsp;<b>Movies</b></v-toolbar-title>
        </v-toolbar>
        <v-toolbar dense> </v-toolbar>
            <v-card dark class="mx-auto" :style="{ backgroundImage: `radial-gradient(circle at 20% 50%, rgb(60, 30, 30) 0%, rgba(27.45%, 13.73%, 13.73%, 0.7) 20%), url(${coverImage})` }">
                <v-container dark class="mx-auto" style="max-width: 1000px;">
                    <v-row justify="space-between">
                        <v-col cols="auto">
                            <v-img :src="poster" alt="..." width="300px" height="450px"></v-img>
                        </v-col>
                        <v-col cols="70%" class="text-left pl-12">
                            <v-row class="flex-column ma-0 fill-height" >
                                <v-col class="px-0">
                                    <h1><b>{{ movieData.title}}</b></h1>
                                </v-col>
                                <v-col class="px-0">
                                    <v-card-actions>
                                        <ul class="pl-0" style="list-style-type:none; display: -webkit-inline-box;">
                                            <li class="pr-6">
                                                <v-progress-circular color="green" size="60" width="8" :value="userRating">{{userRating}}%</v-progress-circular>
                                                User Score
                                            </li>
                                            <li v-show="vdoPresent" class="pl-5">
                                                <v-btn icon class="mt-3" @click="showMovie = true"><v-icon style="font-size: 60px;">mdi-play-circle-outline</v-icon> </v-btn>
                                            </li>
                                            <li v-show="vdoPresent" class="mt-4 pl-3">
                                                Play Trailer
                                            </li>
                                        </ul>
                                    </v-card-actions>
                                </v-col>
                                <v-col class="px-0">
                                    <h4 class="ml-0">Overview</h4>
                                    <p>{{movieData.overview}}</p>
                                </v-col>
                                <v-col class="px-0">
                                    <h6 v-if="movieData.status === 'Released'"><b>Released on: </b> {{movieData.release_date}}</h6>
                                    <h6 v-else><b>Release Date: </b>{{movieData.release_date}}</h6>
                                </v-col>
                            </v-row>
                        </v-col>
                    </v-row>
                </v-container>
            </v-card>
    </v-container>
</template>
<script>
export default{
    data() {
        return{
            movie_id: '',
            movieData: {},
            poster: '',
            coverImage: '',
            userRating: 0,
            vdoPath: '',
            showMovie: false,
            vdoPresent: false
        }
    },
    methods: {
        playMovie() {
            var url = 'https://api.themoviedb.org/3/movie/' + this.movie_id + '/videos?api_key=03906c3cc78de82cc99aadcdd24d6fa2&language=en-US'
            var self = this;
            $.ajax({
                url: url,  
                dataType: "json", 
                type: "GET",
                success: function (data) {
                    self.movieData = data;
                    self.poster = 'https://image.tmdb.org/t/p/original' + data.poster_path;
                    self.coverImage = 'https://image.tmdb.org/t/p/original' + data.backdrop_path;
                    self.userRating = data.vote_average * 10;
                },
            });
        }
    },
    created() {
        this.$vuetify.theme.dark = false;
        this.movie_id = this.$route.params.movie_id
        var url = 'https://api.themoviedb.org/3/movie/' + this.movie_id + '?api_key=03906c3cc78de82cc99aadcdd24d6fa2&language=en-US'
        var self = this;
        $.ajax({
            url: url,  
            dataType: "json", 
            type: "GET",
            success: function (data) {
                self.movieData = data;
                self.poster = 'https://image.tmdb.org/t/p/original/' + data.poster_path;
                self.coverImage = 'https://image.tmdb.org/t/p/original/' + data.backdrop_path;
                self.userRating = data.vote_average * 10;
            },
        });
    },
    mounted(){
        var url = 'https://api.themoviedb.org/3/movie/' + this.movie_id + '/videos?api_key=03906c3cc78de82cc99aadcdd24d6fa2'
        var self = this;
        $.ajax({
            url: url,  
            dataType: "json", 
            type: "GET",
            success: function (data) {
                if(data.results.length === 0){
                    return;
                }
                else{
                    self.vdoPresent = true;
                    self.vdoPath = 'https://www.youtube.com/embed/' + data.results[0].key + '?autoplay=1';
                }
            },
        });
    }
}
</script>
<style scoped>
    .v-image__image{
        display: block;       
        border-width: 0px;
        outline: none;
        position: relative;
    }
    h2,h4,h6{
        display: inline-block !important;
        
    }
    .container--fluid{
        background-image: radial-gradient(circle at 20% 50%, rgb(60, 30, 30) 0%, rgba(27.45%, 13.73%, 13.73%, 0.88) 100%) !important;
        position: fixed;
        padding: 0;
    }

</style>
<!-- url: `https://api.themoviedb.org/3/${self.movie_id}/videos?api_key=03906c3cc78de82cc99aadcdd24d6fa2&language=en-US`, -->