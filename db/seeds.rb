User.create!(name:  "採用　太郎",
             email: "moveapp@example.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true)
             
User.create!(name:  "first user",
            email:  "first@first.com",
            password:              "first1",
            password_confirmation: "first1",
            activated: true)
             
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true)
end

users = User.order(:created_at).take(3)
40.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end