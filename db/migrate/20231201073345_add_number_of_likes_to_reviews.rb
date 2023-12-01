class AddNumberOfLikesToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :number_of_likes, :integer, default: 0
  end
end
