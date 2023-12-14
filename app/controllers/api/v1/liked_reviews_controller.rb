class Api::V1::LikedReviewsController < SecuredController
  # skip_before_action :authorize_request

  def index
    liked_reviews = @current_user.likes.map(&:review)
    render json: liked_reviews
  end
end
