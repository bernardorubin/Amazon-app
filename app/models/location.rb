class Location < ApplicationRecord
 belongs_to :user

 geocoded_by :ip_address
 after_validation :geocode

 validates :user_id, presence: true
end
