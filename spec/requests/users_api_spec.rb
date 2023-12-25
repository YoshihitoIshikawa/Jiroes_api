require 'rails_helper'

describe 'GET /users', type: :request do
  it 'returns all users' do
    10.times do |i|
      FactoryBot.create(:user, sub: "unique_sub_#{i}")
    end

    get api_v1_users_path
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.length).to eq(10)
  end
end

describe 'POST /users', type: :request do
  it 'creates a new user' do
    new_user = {
      sub: "new_sub",
    }
    post api_v1_users_path, params: new_user

    expect(response.status).to eq(201)
    expect(User.count).to eq(1)

    created_user = JSON.parse(response.body)

    expect(created_user['sub']).to eq(new_user[:sub])
  end
end

describe 'PATCH users/:sub' do
  let(:user) { create(:user, { sub: 'auth0|12345678abc' }) }

  context 'when in production environment' do
    before do
      authorization_stub
      # rubocop:disable all
      allow(Rails.env).to receive(:production?).and_return(true)
      # rubocop:enable all
    end

    it 'updates the user picture' do
      new_picture = 'https://example.com/picture.jpg'

      # 実際には存在しないテスト用のsubの為、テストでは'the user does not exist'のエラーになる事を想定
      expect do
        patch api_v1_user_path(user.sub), params: { sub: user.sub, picture: new_picture }
      end.to raise_error(Auth0::NotFound)
    end
  end

  context 'when in non-production environment' do
    before do
      authorization_stub
      # rubocop:disable all
      allow(Rails.env).to receive(:production?).and_return(false)
      # rubocop:enable all
    end

    it 'does not update the user picture and returns unprocessable entity status' do
      new_picture = fixture_file_upload('test.png', 'image/jpeg')

      patch api_v1_user_path(user.sub), params: { sub: user.sub, picture: new_picture }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
