class Api::V1::LikesController < SecuredController
  def create
    @review = Review.find(params[:review_id])
    like = Like.new(review: @review)
    if like.save
      @review.increment!(:number_of_likes)
      render json: { liked: true, number_of_likes: @review.number_of_likes }
    else
      render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @review = @like.review
    @like.destroy
    @review.decrement!(:number_of_likes)
    render json: { liked: false, number_of_likes: @review.number_of_likes }
  end
end
