<template>
    <v-container>
        <v-row justify="center">
            <v-toolbar dark>
                <v-toolbar-title><v-icon>mdi-movie</v-icon>&nbsp;<b>Movies</b></v-toolbar-title>
                <div class="flex-grow-1"></div>
                <v-btn icon @click=navigateHome>
                    <v-icon>mdi-home</v-icon>
                </v-btn>
                <v-btn icon>
                    <v-icon>mdi-dots-vertical</v-icon>
                </v-btn>
                </v-toolbar>
            <v-container>
            <div class="content">
                <v-card-text>
                    <v-sheet class="mx-auto">
                    <h5> Popular in Hollywood </h5>
                    <v-slide-group multiple show-arrows>
                        <v-slide-item v-for="movie in hollywoodData.results" v-slot:default="{ active, toggle }">
                            <div class="flip-card">
                                <div class="flip-card-front">
                                    <v-card color="white">                                       
                                        <v-img :src="imageUrl + movie.poster_path" alt="..." max-height="355"></v-img>
                                        <v-card-title>
                                            {{ movie.title }}
                                        </v-card-title>
                                        <v-card-text>
                                            <v-icon color="red">mdi-heart</v-icon>
                                            {{ movie.vote_average * 10 }}%
                                        </v-card-text>
                                    </v-card>
                                </div>
                                <div class="flip-card-back">
                                    <v-card color="white"> 
                                        <v-card-text>{{ movie.overview }}</v-card-text>
                                        <v-btn color="info" target="_blank" :href="'https://www.themoviedb.org/movie/'+ movie.id">Details</v-btn>                                  
                                    </v-card>
                                </div>
                            </div>
                        </v-slide-item>
                    </v-slide-group>
                    </v-sheet>
                    <br />
                    <br />
                    <br />
                    <v-sheet class="mx-auto">
                        <h5> Popular in Bollywood </h5>
                        <v-slide-group multiple show-arrows>
                                <v-slide-item v-for="movie in bollywoodData.results" v-slot:default="{ active, toggle }">
                                    <div class="flip-card">
                                        <div class="flip-card-front">
                                            <v-card color="white">                                       
                                                <v-img :src="imageUrl + movie.poster_path" alt="..." max-height="355"></v-img>
                                                <v-card-title>
                                                    {{ movie.title }}
                                                </v-card-title>
                                                <v-card-text>
                                                    <v-icon color="red">mdi-heart</v-icon>
                                                    {{ movie.vote_average * 10 }}%
                                                </v-card-text>
                                            </v-card>
                                        </div>
                                        <div class="flip-card-back">
                                            <v-card color="white"> 
                                                <v-card-text>{{ movie.overview }}</v-card-text>
                                                <v-btn color="info" target="_blank" :href="'https://www.themoviedb.org/movie/'+ movie.id">Details</v-btn>                                  
                                            </v-card>
                                        </div>
                                    </div>
                                </v-slide-item>
                            </v-slide-group>
                        </v-sheet>
                </v-card-text>
            </div>
        </v-container> 
        </v-row>
    </v-container>
</template>
<script>  
export default{
    data() {
        return{
            hollywoodData: {},
            bollywoodData: {},
            imageUrl: ''
        }
    },
    methods: {
        navigateHome() {
            this.$router.push({path: '/'});
        }
    },
    created() {
        this.$vuetify.theme.dark = false;
        var self = this;
        $.ajax({
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', localStorage.csrf);
                xhr.setRequestHeader('Authorization', 'Bearer ' + localStorage.access);
                },
            url: '/api/widgets/movies',
            dataType: "json", 
            type: "GET",
            success: function (data) {
                console.log(data)
                console.log(data.hollywoodData.results)
                self.hollywoodData = data.hollywoodData;
                self.bollywoodData = data.bollywoodData;
                self.imageUrl = data.imageurl;  
            },
            error: function(xhr, textstatus) {
                delete localStorage.csrf
                delete localStorage.access
                delete localStorage.signedIn
                window.href.location = "/" 
            }
        });
    }
}
</script>
<style scoped>
    .content{
        display: flex;
        margin: 0 auto;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        background-color: #f2f2f2 !important;
    }
    .v-card__title{
        font-size: 1rem !important;
        padding-bottom: 0 !important;
        padding-top: 10px !important;
    }
    .v-slide-group{
        background-color: #f2f2f2 ;
    }
    header{
        background-color: #000000;
        background-image: linear-gradient(141deg, #5a7167 0%, #190101bf 51%, #690303 75%);
    }
    h5{
        background-color: #f2f2f2 ;
        font-size: 18px;
        line-height: 21px;
        color: #333;
        font-weight: 700;
        margin: 0;
        padding: 30px;
    }
    .flip-card{
        background-color: transparent;
        width: 301px;
        height: 455px;
        perspective: 1000px;
        position: relative;
        transition: ease-in-out 2s;
        transform-style: preserve-3d;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
        margin: 10px 20px;;
    }
    .flip-card:hover {
        transform: rotateY(180deg);
    }
    .flip-card-front, .flip-card-back{
        position: absolute;
        width: 100%;
        height: 100%;
        display: flex;
        backface-visibility: hidden;
        transform-style: preserve-3d;
        transition: ease-in-out 2s;
    }
    .flip-card-front{
        background: #fff;
        font-family: Poppins, sans-serif;
    }
    .flip-card-back{
        background: #fff;
        transform: rotateY(-180deg);
        text-align: center;
        justify-content: center;
        align-items: center;
        position: absolute;
        height: 100%;
        width: 100%;
        -webkit-backface-visibility: hidden;
        backface-visibility: hidden;
    }
    .flip-card.v-card{
        width: 100%;
        height: 100%;
    }
</style>