require "faker"
require "open-uri"

puts "🔄 Nettoyage des données..."

Event.delete_all
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('events')

puts "👤 Ajout des utilisateurs"
User.create!(first_name: "rosa", last_name: "rosa", email: "test@test.com", description: Faker::Hipster.paragraphs(number: 2), encrypted_password: "password")
10.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  password = "password"
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}_#{last_name}#{i}@yopmail.com",
    encrypted_password: password,
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
  Event.create!(
    title: Faker::Hipster.sentence(word_count: 2),
    description: Faker::Hipster.paragraphs(number: 2).join("\n"),
    start_date: DateTime.now + rand(1..30).days,
    location: Faker::Address.city,
    price: rand(1..1000),
    user: User.all.sample,
    duration: [ 30, 60, 90, 120 ].sample
  )
end

puts "✅ Seeds terminés !"
