class Track < ActiveRecord::Base
  BONUS = {
    b: :bonus,
    r: :regular
  }
  validates :album_id, :name, :bonus, presence: true
  validates :bonus, inclusion: { in: BONUS.keys }

  belongs_to :album

  has_one :artist,
    through: :album,
    source: :artist

end
