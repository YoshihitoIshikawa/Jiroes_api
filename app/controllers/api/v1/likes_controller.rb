class Api::V1::LikesController < SecuredController
  skip_before_action :authorize_request, only: [:index]

  def index
    @review = Review.find(params[:review_id])
    @likes = @review.likes
    render json: @likes
  end

  def create
    @review = Review.find(params[:review_id])
    @like = Like.new(like_params)
    if @like.save
      @review.increment!(:number_of_likes)
      render json: [@like, { number_of_likes: @review.number_of_likes }]
    else
      render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @review = @like.review
    @like.destroy
    @review.decrement!(:number_of_likes)
    render json: [@like, { number_of_likes: @review.number_of_likes }]
  end

  private

  def like_params
    params.permit(:sub, :review_id, :shop_id)
  end
end
