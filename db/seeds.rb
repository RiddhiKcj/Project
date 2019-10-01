# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(username: "riddhi", email: "ridds509@gmail.com", password: "111111", password_confirmation: "111111")
Globalapi.create!(name: "weather", url: "https://api.darksky.net/forecast/", api: "adedecd668be4b048d9408469258ab9a", active: true)
Globalapi.create!(name: "news", url: "https://newsapi.org/v2/top-headlines?sources=the-hindu&apiKey=", api: "352350466a754313b9f8be2e8b9fd41d", active: true)
Globalapi.create!(name: "currencyexc", url: "http://www.apilayer.net/api/live?access_key=", api: "a239bfb10e94ca269f81b28990c0a585", active: true)
