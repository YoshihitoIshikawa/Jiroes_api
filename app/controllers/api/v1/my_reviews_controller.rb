class Api::V1::MyReviewsController < SecuredController
  def index
    reviews = Review.where(sub: @current_user.sub).order(created_at: :desc)
    render json: reviews
  end
end
