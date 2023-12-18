require 'rails_helper'

RSpec.describe "Api::V1::LikedReviewsController", type: :request do
  let!(:current_user) { create(:user) }
  let!(:shop) { create(:shop) }
  let!(:review) { create(:review, shop: shop, sub: current_user.sub) }
  let!(:like) { create(:like, shop: shop, review: review, sub: current_user.sub) }

  describe "GET /api/v1/liked_reviews/index" do
    # トークン期限切れの関係で、テスト時にトークンを取得しtokenに代入
    # it "successfully accesses the liked_reviews path" do
    #   token = ""
    #   get api_v1_liked_reviews_index_path, headers: { Authorization: "Bearer #{token}"}

    #   expect(response.status).to eq(200)
    # end
  end
end
