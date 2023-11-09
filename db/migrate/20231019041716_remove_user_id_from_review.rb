class RemoveUserIdFromReview < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :user_id
  end
end
