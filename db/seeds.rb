require 'faker'

# Create Ultra user (owns all content if no user assigned)
ultra = User.new(
  name: "Ultrapedia",
  email: "ultra@blocipedia.com",
  password: "supersecret",
  password_confirmation: "supersecret",
  role: "admin"
)
ultra.skip_confirmation!
ultra.save

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

# Create standard user
standard = User.new(
  name: "StandardUser",
  email: "user@example.com",
  password: "password",
  password_confirmation: "password",
  role: "standard"
)
standard.skip_confirmation!
standard.save

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