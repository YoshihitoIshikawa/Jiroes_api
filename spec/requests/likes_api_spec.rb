require 'rails_helper'

RSpec.describe "Api::V1::LikesController", type: :request do
  let!(:current_user) { create(:user) }
  let!(:shop) { create(:shop) }
  let!(:review) { create(:review, shop: shop, sub: current_user.sub) }
  let!(:like) { create(:like, shop: shop, review: review, sub: current_user.sub) }

  before do
    authorization_stub
  end

  describe "GET /api/v1/shops/:shop_id/reviews/:review_id/likes" do
    it "returns all likes for a review" do
      get api_v1_shop_review_likes_path(shop.id, review.id)

      expect(response.status).to eq(200)

      reviews_json = JSON.parse(response.body)
      expect(reviews_json.length).to eq(1)
    end
  end

  describe "POST /api/v1/shops/:shop_id/reviews/:review_id/likes" do
    it "creates a new like" do
      like_params = {
        sub: current_user.sub,
        shop_id: shop.id,
        review_id: review.id,
      }

      post api_v1_shop_review_likes_path(shop.id, review.id), params: like_params

      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/v1/shops/:shop_id/reviews/:review_id/likes/:like_id' do
    it 'deletes a review' do
      delete api_v1_shop_review_like_path(shop.id, review.id, like.id)

      expect(response.status).to eq(200)
    end
  end
end
