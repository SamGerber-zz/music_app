User.create!(email: "sam@example.com", password: "asdasd")

10.times do
  Band.create(name: Faker::Book.title)
end
