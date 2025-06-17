require "faker"
require "open-uri"

puts "🔄 Nettoyage des données..."

Event.delete_all
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('events')

puts "👤 Ajout des utilisateurs"
User.create!(first_name: "rosa", last_name: "rosa", email: "test@test.com", description: Faker::Hipster.paragraphs(number: 2), password: "password", password_confirmation: "password")
10.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  password = "password"
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}_#{last_name}#{i}@yopmail.com",
    password: password,
    password_confirmation: password,
    description: Faker::Hipster.paragraphs(number: 2).join("\n"),
  )
end

puts "📅 Ajout des événements"
Event.create!(
  title: "Workshop rollerskate",
  description: Faker::Hipster.paragraphs(number: 2).join("\n"),
  start_date: DateTime.now + 1.day,
  location: Faker::Address.street_address,
  price: 10.0,
  user: User.all.sample,
  duration: 90
)
10.times do
  date = Date.today + rand(1..90)
  hour = rand(8..20)
  minute = [ 0, 15, 30, 45 ].sample
  start_datetime = DateTime.new(date.year, date.month, date.day, hour, minute)
  Event.create!(
    title: Faker::Hipster.sentence(word_count: 2),
    description: Faker::Hipster.paragraphs(number: 2).join("\n"),
    start_date: start_datetime,
    location: Faker::Address.street_address,
    price: rand(1..1000),
    user: User.all.sample,
    duration: [ 30, 60, 90, 120 ].sample
  )
end

puts "✅ Seeds terminés !"
