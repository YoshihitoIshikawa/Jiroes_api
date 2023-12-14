class Api::V1::LikedReviewsController < SecuredController
  def index
    likes = Like.where(sub: @current_user.sub)
    review_ids = likes.map { |like| like['review_id'] }
    liked_reviews = Review.where(id: review_ids)
    render json: liked_reviews
  end
end
