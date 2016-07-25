# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  user = User.new(
    username: Faker::Internet.user_name(nil, %w(_)),
    email: Faker::Internet.safe_email,
    password: "password",
    avatar: Faker::Avatar.image,
    bio: Faker::Hipster.sentence(20)
  )
  if user.save
    20.times do
      user.posts.create!(
        body: Faker::Hacker.say_something_smart
      )
    end
    if User.count > 5
      5.times do
        user.follow!(User.where.not(id: user.id).order("RANDOM()").first)
      end
    end
  end
end
