[1mdiff --git a/app/controllers/api_integrators/base_controller.rb b/app/controllers/api_integrators/base_controller.rb[m
[1mdeleted file mode 100644[m
[1mindex e69de29..0000000[m
[1mdiff --git a/app/controllers/api_integrators/news_controller.rb b/app/controllers/api_integrators/news_controller.rb[m
[1mdeleted file mode 100644[m
[1mindex a7d5d20..0000000[m
[1m--- a/app/controllers/api_integrators/news_controller.rb[m
[1m+++ /dev/null[m
[36m@@ -1,10 +0,0 @@[m
[31m-module ApiIntegrators[m
[31m-  class NewsController < ApplicationController[m
[31m-    def index[m
[31m-      newsApi = Globalapi.find_by name: 'news'[m
[31m-      url = newsApi.url[m
[31m-      key = newsApi.key[m
[31m-      @newsData = ApiCalls.newCall(url)[m
[31m-    end[m
[31m-  end[m
[31m-end[m
\ No newline at end of file[m
[1mdiff --git a/app/controllers/api_integrators/weather_controller.rb b/app/controllers/api_integrators/weather_controller.rb[m
[1mdeleted file mode 100644[m
[1mindex 6e0d6da..0000000[m
[1m--- a/app/controllers/api_integrators/weather_controller.rb[m
[1m+++ /dev/null[m
[36m@@ -1,16 +0,0 @@[m
[31m-module ApiIntegrators[m
[31m-  class WeatherController < ApplicationController[m
[31m-    include ApiCaller[m
[31m-    include LocationFetcher[m
[31m-    require 'date'[m
[31m-    def index[m
[31m-      initLocation[m
[31m-      latitude = getLatitude[m
[31m-      longitude = getLongitude[m
[31m-      key = "adedecd668be4b048d9408469258ab9a"[m
[31m-      url = "https://api.darksky.net/forecast/#{key}/#{latitude},#{longitude}"[m
[31m-      @weatherData = newCall(url)[m
[31m-    end [m
[31m-[m
[31m-  end[m
[31m-end[m
\ No newline at end of file[m
[1mdiff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb[m
[1mindex 53a051c..930f069 100644[m
[1m--- a/app/controllers/application_controller.rb[m
[1m+++ b/app/controllers/application_controller.rb[m
[36m@@ -1,20 +1,13 @@[m
 class ApplicationController < ActionController::Base[m
 	before_action :configure_permitted_parameters, if: :devise_controller?[m
 	before_action :authenticate_user![m
[31m-	layout :layout_by_resource[m
[31m-[m
[31m-	def extract_ip_from(request)[m
[31m-		if request.remote_ip == '::1' || request.remote_ip == '127.0.0.1'[m
[31m-			"111.93.220.154"[m
[31m-		else[m
[31m-			request.remote_ip[m
[31m-		end[m
[32m+[m[41m	[m
[32m+[m	[32mdef index[m
[32m+[m		[32mrender template: 'application'[m
 	end[m
 [m
 	protected[m
[31m-	def layout_by_resource[m
[31m-		user_signed_in? ? "application" : "index_layout"[m
[31m-	end[m
[32m+[m
 	def configure_permitted_parameters[m
 		devise_parameter_sanitizer.permit(:sign_up, keys: [:email])[m
 	end[m
[1mdiff --git a/app/controllers/news_controller.rb b/app/controllers/news_controller.rb[m
[1mdeleted file mode 100644[m
[1mindex b858bd7..0000000[m
[1m--- a/app/controllers/news_controller.rb[m
[1m+++ /dev/null[m
[36m@@ -1,9 +0,0 @@[m
[31m-class NewsController < ApplicationController[m
[31m-  def index[m
[31m-    newsApi = Globalapi.find_by name: 'news'[m
[31m-    key = newsApi.api[m
[31m-    # url format = '...apiKey='#{key}[m
[31m-    url = newsApi.url + key[m
[31m-    @newsData = JSON.parse(RestClient.get(url))[m
[31m-  end[m
[31m-end[m
[1mdiff --git a/app/controllers/weather_controller.rb b/app/controllers/weather_controller.rb[m
[1mdeleted file mode 100644[m
[1mindex 901d738..0000000[m
[1m--- a/app/controllers/weather_controller.rb[m
[1m+++ /dev/null[m
[36m@@ -1,18 +0,0 @@[m
[31m-class WeatherController < ApplicationController[m
[31m-  require 'rest-client'[m
[31m-  require 'date'[m
[31m-  def index[m
[31m-    user = current_user[m
[31m-    ip = user.last_sign_in_ip || user.current_sign_in_ip[m
[31m-    @location = Geocoder.search(ip)[m
[31m-    @address =  @location.first.address[m
[31m-    latitude = @location.first.coordinates[0][m
[31m-    longitude = @location.first.coordinates[1][m
[31m-    weatherApi = Globalapi.find_by name: 'weather'[m
[31m-    key = weatherApi.api  [m
[31m-    # url format = '..../'#{key}/#{latitude},#{longitude}[m
[31m-    url = weatherApi.url + key + '/' + latitude.to_s + ',' + longitude.to_s[m
[31m-    @weatherData =  JSON.parse(RestClient.get(url))[m
[31m-  end [m
[31m-[m
[31m-end[m
[1mdiff --git a/app/controllers/welcome_controller.rb b/app/controllers/welcome_controller.rb[m
[1mindex ac37a30..a679d1c 100644[m
[1m--- a/app/controllers/welcome_controller.rb[m
[1m+++ b/app/controllers/welcome_controller.rb[m
[36m@@ -3,5 +3,13 @@[m [mclass WelcomeController < ApplicationController[m
     @users = User.all[m
     @user = current_user[m
     @globalApi = Globalapi.all[m
[32m+[m[32m    data = {[m
[32m+[m[32m      :user => @user,[m
[32m+[m[32m      :users => @users,[m
[32m+[m[32m      :globalApi => @globalApi[m
[32m+[m[32m    }[m
[32m+[m[32m    respond_to do |format|[m
[32m+[m[32m      format.json  { render :json => data }[m
[32m+[m[32m    end[m
   end[m
 end[m
[1mdiff --git a/app/javascript/app.vue b/app/javascript/app.vue[m
[1mindex 1dec933..d3773dc 100644[m
[1m--- a/app/javascript/app.vue[m
[1m+++ b/app/javascript/app.vue[m
[36m@@ -1,11 +1,12 @@[m
 <template>[m
   <div>[m
[31m-  <h1>Hello world</h1>[m
[31m-  <v-app id="app" dark>[m
[31m-    <h1>Hello Vuetify</h1>[m
[31m-    <v-btn color="success">Vuetify Button</v-btn>[m
[31m-  </v-app>[m
[31m-    <p>{{ message }}</p>[m
[32m+[m[32m    <v-app id="app" dark>[m
[32m+[m[32m      <v-content>[m
[32m+[m[32m        <div>[m
[32m+[m[32m          <router-view></router-view>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </v-content>[m
[32m+[m[32m    </v-app>[m
   </div>[m
 </template>[m
 [m
[36m@@ -13,15 +14,9 @@[m
 export default {[m
   data: function () {[m
     return {[m
[31m-      message: "Hello Vue!"[m
     }[m
[32m+[m[32m  },[m
[32m+[m[32m  created() {[m
   }[m
 }[m
 </script>[m
[31m-[m
[31m-<style scoped>[m
[31m-p {[m
[31m-  font-size: 2em;[m
[31m-  text-align: center;[m
[31m-}[m
[31m-</style>[m
[1mdiff --git a/app/javascript/packs/hello_vue.js b/app/javascript/packs/hello_vue.js[m
[1mindex 8da43b9..5c32590 100644[m
[1m--- a/app/javascript/packs/hello_vue.js[m
[1m+++ b/app/javascript/packs/hello_vue.js[m
[36m@@ -6,11 +6,11 @@[m
 // All it does is render <div>Hello Vue</div> at the bottom of the page.[m
 [m
 import Vue from 'vue'[m
[31m-import Vuetify from 'vuetify'[m
[32m+[m[32mimport Vuetify from '../src/plugins/vuetify.js'[m
 import 'vuetify/dist/vuetify.min.css'[m
 import 'material-design-icons-iconfont/dist/material-design-icons.css'[m
 import App from '../app.vue'[m
[31m-[m
[32m+[m[32mimport router from '../src/router.js'[m
 Vue.use(Vuetify)[m
 [m
 document.addEventListener('DOMContentLoaded', () => {[m
[36m@@ -18,7 +18,8 @@[m [mdocument.addEventListener('DOMContentLoaded', () => {[m
   const app = new Vue({[m
     el,[m
     render: h => h(App),[m
[31m-    vuetify: new Vuetify({})[m
[32m+[m[32m    vuetify: new Vuetify({}),[m
[32m+[m[32m    router[m
   })[m
 [m
   console.log(app)[m
[1mdiff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb[m
[1mdeleted file mode 100644[m
[1mindex 2f03cb3..0000000[m
[1m--- a/app/views/layouts/application.html.erb[m
[1m+++ /dev/null[m
[36m@@ -1,69 +0,0 @@[m
[31m-<!DOCTYPE html>[m
[31m-<html>[m
[31m-<head>[m
[31m-  <meta charset="UTF-8">[m
[31m-  <title>Blog</title>[m
[31m-  <meta name="viewport" content="width=device-width, initial-scale=1">[m
[31m-  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">[m
[31m-  <link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'>[m
[31m-  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>[m
[31m-  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>[m
[31m-  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js">[m
[31m-  <script src="https://kit.fontawesome.com/f546f94cda.js" crossorigin="anonymous"></script>[m
[31m-  <link href='https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons' rel="stylesheet">[m
[31m-  <%= csrf_meta_tags %>[m
[31m-    <%= csp_meta_tag %>[m
[31m-    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>[m
[31m-    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>[m
[31m-    <%= javascript_include_tag 'application', 'rails.validations' %>[m
[31m-    <%= stylesheet_link_tag    'util', media: 'all', 'data-turbolinks-track': 'reload' %>[m
[31m-</head>[m
[31m-<body>[m
[31m-[m
[31m-<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">[m
[31m-    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">[m
[31m-      <span class="navbar-toggler-icon"></span>[m
[31m-    </button>[m
[31m-    <div class="navbar-brand">[m
[31m-      <strong>Welcome </strong>[m
[31m-      <% if current_user.username.blank? %>[m
[31m-        <strong><%= current_user.email %></strong>[m
[31m-      <% else %>[m
[31m-        <strong><%= current_user.username.humanize %></strong>[m
[31m-      <% end %></strong>[m
[31m-    </div>[m
[31m-    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">[m
[31m-[m
[31m-      <ul class="navbar-nav navbar-right mr-auto mt-2 mt-lg-0">[m
[31m-        <li class="nav-item active"><%= link_to welcome_index_path, class:"nav-link" do %>[m
[31m-          <i class="fa fa-home nav-item" aria-hidden="true"></i> Home[m
[31m-          <% end %>[m
[31m-        </li>[m
[31m-        <li class="nav-item"><%= link_to edit_user_registration_path, class:"nav-link" do %>[m
[31m-          <i class="fa fa-user nav-item" aria-hidden="true"></i> Edit Profile[m
[31m-          <% end %>[m
[31m-        </li>[m
[31m-        <li class="nav-item nav-item"><%= link_to destroy_user_session_path , class:"nav-link", method: :delete do %>[m
[31m-          <i class="fa fa-sign-out" aria-hidden="true"></i> Logout[m
[31m-          <% end %>[m
[31m-        </li>[m
[31m-      </ul>[m
[31m-    </div>[m
[31m-</nav> [m
[31m-<div class="container box">  [m
[31m-    <div class="header">  [m
[31m-      <% flash.each do |name, msg| %>[m
[31m-        <%= content_tag :div, class: "alert alert-info alert-dismissible" do %>[m
[31m-          <%= msg %>[m
[31m-          <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>[m
[31m-        <% end %>[m
[31m-      <% end %>[m
[31m-    </div>[m
[31m-      <%= yield %> [m
[31m-  </div>[m
[31m- <div class="footer">&copy; BlogApp-rk.com[m
[31m- </div>[m
[31m- <%= javascript_pack_tag 'application' %>[m
[31m- <%= javascript_pack_tag 'hello_vue' %>[m
[31m-</body>[m
[31m-</html>[m
\ No newline at end of file[m
[1mdiff --git a/app/views/welcome/index.html.erb b/app/views/welcome/index.html.erb[m
[1mindex 64bddfb..d25cb8e 100644[m
[1m--- a/app/views/welcome/index.html.erb[m
[1m+++ b/app/views/welcome/index.html.erb[m
[36m@@ -1,26 +1,26 @@[m
 [m
[31m-<div class="btn-group" role="group">[m
[31m-    <% @globalApi.each do |gApi| %>[m
[31m-        <% if gApi.active %>[m
[31m-            <%= form_with(model: [ @user, @user.myapis.build ], local: true, xhr: true) do |form| %>[m
[31m-                <%= form.hidden_field :name, value:gApi.name%>[m
[31m-                <%= form.hidden_field :url, value:gApi.url%>[m
[31m-                <%= form.hidden_field :api, value: gApi.api %>[m
[31m-                <%= form.submit gApi.name.humanize, class:"btn btn-secondary api"%>[m
[31m-            <% end %>[m
[31m-        <% end %>[m
[31m-    <% end %>[m
[31m-</div>[m
[31m-<h3><strong>My APIs</strong></h3><hr/>[m
[31m-<div id="api"></div>[m
[31m-<div class="p-b-40">[m
[31m-    <table class="table table-striped table-hover">[m
[31m-        <% if @user.myapis.any? %>[m
[31m-            <% @user.myapis.each do |api| %>[m
[31m-                <%= api.name %>[m
[31m-            <% end %>[m
[31m-        <% end %>[m
[31m-    </table>[m
[31m-</div>[m
[31m-<script>[m
[31m-document.getElemetsByTagName()[m
\ No newline at end of file[m
[32m+[m[32m# <div class="btn-group" role="group">[m
[32m+[m[32m#     <% @globalApi.each do |gApi| %>[m
[32m+[m[32m#         <% if gApi.active %>[m
[32m+[m[32m#             <%= form_with(model: [ @user, @user.myapis.build ], local: true, xhr: true) do |form| %>[m
[32m+[m[32m#                 <%= form.hidden_field :name, value:gApi.name%>[m
[32m+[m[32m#                 <%= form.hidden_field :url, value:gApi.url%>[m
[32m+[m[32m#                 <%= form.hidden_field :api, value: gApi.api %>[m
[32m+[m[32m#                 <%= form.submit gApi.name.humanize, class:"btn btn-secondary api"%>[m
[32m+[m[32m#             <% end %>[m
[32m+[m[32m#         <% end %>[m
[32m+[m[32m#     <% end %>[m
[32m+[m[32m# </div>[m
[32m+[m[32m# <h3><strong>My APIs</strong></h3><hr/>[m
[32m+[m[32m# <div id="api"></div>[m
[32m+[m[32m# <div class="p-b-40">[m
[32m+[m[32m#     <table class="table table-striped table-hover">[m
[32m+[m[32m#         <% if @user.myapis.any? %>[m
[32m+[m[32m#             <% @user.myapis.each do |api| %>[m
[32m+[m[32m#                 <%= api.name %>[m
[32m+[m[32m#             <% end %>[m
[32m+[m[32m#         <% end %>[m
[32m+[m[32m#     </table>[m
[32m+[m[32m# </div>[m
[32m+[m[32m# <script>[m
[32m+[m[32m# document.getElemetsByTagName()[m
\ No newline at end of file[m
[1mdiff --git a/config/routes.rb b/config/routes.rb[m
[1mindex 6e580e4..18cfd35 100644[m
[1m--- a/config/routes.rb[m
[1m+++ b/config/routes.rb[m
[36m@@ -3,12 +3,19 @@[m [mRails.application.routes.draw do[m
   devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations", confirmations: "users/confirmations" }[m
   get 'welcome/index'[m
   #root 'articles#index'[m
[31m-  root 'welcome#index'[m
[32m+[m[32m  # root 'api/welcome#index', :defaults => { :format => 'json' }[m
[32m+[m
[32m+[m[32m  namespace :api, :defaults => { :format => 'json' } do[m
[32m+[m[32m    resources :weather, only: :index[m
[32m+[m[32m    resources :news, only: :index[m
[32m+[m[32m  end[m
   resources :users,  only: :index do[m
   	resources :myapis, only: [:new, :create, :destroy][m
   end[m
[31m-  get 'news/index'[m
[31m-  get 'weather/index'[m
[31m-[m
[32m+[m[32m  # get 'news/index'[m
[32m+[m[32m  # get 'weather/index'[m
 [m
[32m+[m[32m  root :to => "application#index"[m
[32m+[m[32m  match "*path", to: "application#index", format: false, via: :get[m
[32m+[m[41m  [m
 end[m
[1mdiff --git a/config/webpack/loaders/vue.js b/config/webpack/loaders/vue.js[m
[1mindex 4576b03..1fbb83a 100644[m
[1m--- a/config/webpack/loaders/vue.js[m
[1m+++ b/config/webpack/loaders/vue.js[m
[36m@@ -4,6 +4,7 @@[m [mconst isProduction = process.env.NODE_ENV === 'production'[m
 const inDevServer = process.argv.find(v => v.includes('webpack-dev-server'))[m
 const extractCSS = !(inDevServer && (devServer && devServer.hmr)) || isProduction[m
 [m
[32m+[m
 module.exports = {[m
   test: /\.vue(\.erb)?$/,[m
   use: [{[m
[1mdiff --git a/package.json b/package.json[m
[1mindex eeeae5d..10e3ec8 100644[m
[1m--- a/package.json[m
[1m+++ b/package.json[m
[36m@@ -7,8 +7,10 @@[m
     "moment": "^2.24.0",[m
     "vue": "^2.6.10",[m
     "vue-loader": "14.2.2",[m
[32m+[m[32m    "vue-router": "^3.1.3",[m
     "vue-template-compiler": "^2.6.10",[m
     "vuetify": "^2.0.19",[m
[32m+[m[32m    "vuetify-loader": "^1.3.0",[m
     "webpack-merge": "^4.2.2"[m
   },[m
   "devDependencies": {[m
[1mdiff --git a/yarn.lock b/yarn.lock[m
[1mindex 5a52f78..c3fa4c5 100644[m
[1m--- a/yarn.lock[m
[1m+++ b/yarn.lock[m
[36m@@ -3905,7 +3905,7 @@[m [mloader-runner@^2.3.0:[m
   resolved "https://registry.yarnpkg.com/loader-runner/-/loader-runner-2.4.0.tgz#ed47066bfe534d7e84c4c7b9998c2a75607d9357"[m
   integrity sha512-Jsmr89RcXGIwivFY21FcRrisYZfvLMTWx5kOLc+JTxtpBOG6xML0vzbc6SEQG2FO9/4Fc3wW4LVcB5DmGflaRw==[m
 [m
[31m-loader-utils@^1.0.1, loader-utils@^1.0.2, loader-utils@^1.1.0:[m
[32m+[m[32mloader-utils@^1.0.1, loader-utils@^1.0.2, loader-utils@^1.1.0, loader-utils@^1.2.0:[m
   version "1.2.3"[m
   resolved "https://registry.yarnpkg.com/loader-utils/-/loader-utils-1.2.3.tgz#1ff5dc6911c9f0a062531a4c04b609406108c2c7"[m
   integrity sha512-fkpz8ejdnEMG3s37wGL07iSBDg99O9D5yflE9RGNH3hRdx9SOwYfnGYdZOUIZitN8E+E2vkq3MUMYMvPYl5ZZA==[m
[36m@@ -7355,6 +7355,11 @@[m [mvue-loader@14.2.2:[m
     vue-style-loader "^4.0.1"[m
     vue-template-es2015-compiler "^1.6.0"[m
 [m
[32m+[m[32mvue-router@^3.1.3:[m
[32m+[m[32m  version "3.1.3"[m
[32m+[m[32m  resolved "https://registry.yarnpkg.com/vue-router/-/vue-router-3.1.3.tgz#e6b14fabc0c0ee9fda0e2cbbda74b350e28e412b"[m
[32m+[m[32m  integrity sha512-8iSa4mGNXBjyuSZFCCO4fiKfvzqk+mhL0lnKuGcQtO1eoj8nq3CmbEG8FwK5QqoqwDgsjsf1GDuisDX4cdb/aQ==[m
[32m+[m
 vue-style-loader@^4.0.1:[m
   version "4.1.2"[m
   resolved "https://registry.yarnpkg.com/vue-style-loader/-/vue-style-loader-4.1.2.tgz#dedf349806f25ceb4e64f3ad7c0a44fba735fcf8"[m
[36m@@ -7381,6 +7386,13 @@[m [mvue@^2.6.10:[m
   resolved "https://registry.yarnpkg.com/vue/-/vue-2.6.10.tgz#a72b1a42a4d82a721ea438d1b6bf55e66195c637"[m
   integrity sha512-ImThpeNU9HbdZL3utgMCq0oiMzAkt1mcgy3/E6zWC/G6AaQoeuFdsl9nDhTDU3X1R6FK7nsIUuRACVcjI+A2GQ==[m
 [m
[32m+[m[32mvuetify-loader@^1.3.0:[m
[32m+[m[32m  version "1.3.0"[m
[32m+[m[32m  resolved "https://registry.yarnpkg.com/vuetify-loader/-/vuetify-loader-1.3.0.tgz#759f1d16f3f211eddbeeffc5c0b24105f2582b07"[m
[32m+[m[32m  integrity sha512-emKS3GWpx+0kWRHfoxpDpLR4HaXvhDn9bYNQf+IaaD5iU5S3xktDyS0egG7dp/oHLQr1U/Ui9g2ElhZUkdgRqw==[m
[32m+[m[32m  dependencies:[m
[32m+[m[32m    loader-utils "^1.2.0"[m
[32m+[m
 vuetify@^2.0.19:[m
   version "2.0.19"[m
   resolved "https://registry.yarnpkg.com/vuetify/-/vuetify-2.0.19.tgz#f2da44987d1bddbd61b8ffcff34056e5eb5f5ec8"[m
