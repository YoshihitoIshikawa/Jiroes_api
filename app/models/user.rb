class User < ApplicationRecord
  self.primary_key = :sub

  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.from_token_payload(payload)
    find_by(sub: payload['sub']) || create!(sub: payload['sub'])
  end

  mount_uploader :picture, PictureUploader
end
