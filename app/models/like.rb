class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :shop
end
