require 'rails_helper'

RSpec.describe "Api::V1::MyReviewsController", type: :request do
  let!(:current_user) { create(:user) }
  let!(:shop) { create(:shop) }
  let!(:review) { create(:review, shop: shop, sub: current_user.sub) }

  describe "GET /api/v1/my_reviews/index" do
    # トークン期限切れの関係で、テスト時にトークンを取得しtokenに代入
    it "successfully accesses the my_reviews path" do
      token = ""
      get api_v1_liked_reviews_index_path, headers: { Authorization: "Bearer #{token}" }

      expect(response.status).to eq(200)
    end
  end
end
