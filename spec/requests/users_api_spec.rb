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
