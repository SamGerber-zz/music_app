User.create!(email: "sam@example.com", password: "asdasd")

10.times do
  band = Band.new(name: Faker::Book.title)
  band.save
  rand(10).times do
    options = {}
    options[:band_id] = band.id
    options[:title] = Faker::Company.bs
    options[:venue] = Album::VENUES.keys.sample
    album = Album.new(options)
    album.save
  end
end
