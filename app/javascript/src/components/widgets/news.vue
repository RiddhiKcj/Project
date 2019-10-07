<template>
  <layout>
    <div class="container">
      <v-row justify="center">
        <div v-for="(val,key) in newsData">
          <div v-if="key === 'articles'">
            <div v-for="param in val" class="news-outer-box"> 
              <div class="news-inner-box">
                <div class="news-img"><img class="news-img" alt="..." :src=" param.urlToImage">
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
      console.log('reached news');
      var self = this;
      $.ajax({
        url: '/api/widgets/news',
        dataType: "json", 
        type: "GET",
        success: function (data) {
          console.log(data);
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