class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'sub', primary_key: 'sub', inverse_of: :likes
  belongs_to :review
  belongs_to :shop
end
