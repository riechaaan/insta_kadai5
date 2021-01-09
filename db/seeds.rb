50.times do |n|
  n = 0 if n > 9
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    # image: File.open(Rails.root + "db/fixtures/icon#{n}.png", "r")
    image: open(Rails.root + "db/fixtures/icon#{n}.png")
    )
end
