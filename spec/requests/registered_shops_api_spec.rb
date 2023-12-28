require 'rails_helper'

RSpec.describe "Api::V1::RegisteredShopsController", type: :request do
  let!(:current_user) { create(:user) }
  let!(:shop) { create(:shop, sub: current_user.sub) }

  describe "GET /api/v1/registered_shops/index" do
    # トークン期限切れの関係で、テスト時にトークンを取得しtokenに代入
    # it "successfully accesses the registered_shops path" do
    #   token = ""
    #   get api_v1_registered_shops_index_path, headers: { Authorization: "Bearer #{token}" }

    #   expect(response.status).to eq(200)
    # end
  end
end
