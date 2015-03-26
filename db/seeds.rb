require 'faker'

# Create Ultra user (owns all content if no user assigned)
user = User.new(
  name: "Ultrapedia",
  email: "ultra@blocipedia.com",
  password: "supersecret",
  password_confirmation: "supersecret",
  role: "admin"
)
user.skip_confirmation!
user.save

# Create admin user
user = User.new(
  name: "Administrator",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  role: "admin"
)
user.skip_confirmation!
user.save

# Create standard user
user = User.new(
  name: "StandardUser",
  email: "user@example.com",
  password: "password",
  password_confirmation: "password",
  role: "standard"
)
user.skip_confirmation!
user.save

# Create private wikis
5.times do
  Wiki.create!(
    title:        Faker::Lorem.sentence,
    subtitle:     Faker::Lorem.sentence,
    body:         Faker::Lorem.paragraph,
    user:         admin,
    private:      true
  )
end

# Create non-private wikis
45.times do
  Wiki.create!(
    title:        Faker::Lorem.sentence,
    subtitle:     Faker::Lorem.sentence,
    body:         Faker::Lorem.paragraph,
    user:         ultra,
    private:      false
  )
end

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
puts "Does the first wiki belong to admin? Result: #{ Wiki.first.user.name == "Administrator" }"