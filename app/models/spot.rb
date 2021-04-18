class Spot < ApplicationRecord
    has_one_attached :image
    acts_as_favoritable
    belongs_to :user
    acts_as_votable
    geocoded_by :location
    after_validation :geocode, if: ->(obj){obj.location.present? and obj.location_changed? }
end
