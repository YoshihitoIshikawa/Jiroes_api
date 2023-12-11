class Shop < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  before_save :geocode_shop_address

  private

  def geocode_shop_address
    coordinates = Geocoder.coordinates(address)
    if coordinates
      self.latitude = coordinates[0]
      self.longitude = coordinates[1]
    end
  end
end
