<template>
    <layout>
        <div class="container">
            <v-row justify="center">
                <div v-for="(val,key) in newsData">
                    <div v-if="key === 'articles'">
                        <div v-for="param in val" class="news-outer-box"> 
                            <div class="news-inner-box">
                                <div class="news-img">
                                    <img class="news-img" alt="..." :src=" param.urlToImage">
                                </div>
                                <div class="news-blogs">
                                    <h3 class="news-heading">
                                    <a class="news-heading" :href="param.url" target="_blank">{{ param.title }}</a>
                                    </h3>
                                    <div class="news-lines">
                                        <p>{{ param.description }}..</p>
                                    </div>
                                </div> 
                            </div>
                        </div>
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
            newsData:{}
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
            url: '/api/widgets/news',
            dataType: "json", 
            type: "GET",
            success: function (data) {
                self.newsData = data.newsData;    
            }
        });
    }
}
</script>
<style scoped>
  h3{
    text-align: center;
  }
</style>