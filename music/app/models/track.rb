# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  name       :string           not null
#  bonus      :string(1)        not null
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
