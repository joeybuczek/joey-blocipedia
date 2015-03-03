require 'faker'

# Create admin user
admin = User.new(
  name: "Administrator",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  role: "admin"
)
admin.skip_confirmation!
admin.save

# Create wikis
45.times do
  Wiki.create!(
    title:        Faker::Lorem.sentence,
    subtitle:     Faker::Lorem.sentence,
    body:         Faker::Lorem.paragraph,
    user:         admin
  )
end

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
puts "Does the first wiki belong to admin? Result: #{ Wiki.first.user.name == "Administrator" }"