# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Example User",
            email: "exampleEmail@gmail.com",
            password: "password",
            password_confirmation: "password",
            admin: true)
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

99.times do |n|
  30.times do |i|
    user = User.find_by(id: n + 1)
    Micropost.create!(
      user_id: n + 1,
      content: "Đây là bài viết thứ #{i + 1} của user #{user.name}"
    )
  end
end