class Api::V1::LikedReviewsController < SecuredController
  def index
    likes = Like.where(sub: @current_user.sub).order(created_at: :desc)
    review_ids = likes.pluck(:review_id)
    liked_reviews = Review.where(id: review_ids).includes(:shop).index_by(&:id).values_at(*review_ids)
    render json: liked_reviews, include: { shop: { only: :name } }
  end
end
