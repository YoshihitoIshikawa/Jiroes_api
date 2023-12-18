class Api::V1::MyReviewsController < SecuredController
  def index
    reviews = Review.includes(:shop).where(sub: @current_user.sub).order(created_at: :desc)
    render json: reviews, include: { shop: { only: :name } }
  end
end
