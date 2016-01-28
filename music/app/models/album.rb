class Album < ActiveRecord::Base
  VENUES = {
    l: :live,
    s: :studio
  }
  validates :band_id, :title, :venue, presence: true
  validates :venue, inclusion: { in: VENUES.keys }

  belongs_to :band
  has_many: :tracks
end
