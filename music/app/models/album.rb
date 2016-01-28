# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  band_id    :integer          not null
#  venue      :string(1)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  VENUES = {
    l: :live,
    s: :studio
  }
  validates :band_id, :title, :venue, presence: true
  validates :venue, inclusion: { in: VENUES.keys }

  belongs_to :band

  has_many :tracks,
    dependent: :destroy
end
