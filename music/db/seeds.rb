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
    (1 + rand(20)).times do
      options = {}
      options[:album_id] = album.id
      options[:name] = Faker::Hipster.words(1 + rand(4)).join(" ").capitalize
      options[:bonus] = Track::BONUS.keys.sample
      lyrics = []
      5.times { lyrics << Faker::Hipster.paragraph(2, false, 4) }
      options[:lyrics] = lyrics.join("\n\n")
      track = Track.new(options)
      track.save
    end
  end
end
