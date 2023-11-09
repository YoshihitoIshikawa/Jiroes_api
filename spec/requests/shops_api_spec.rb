require 'rails_helper'

describe 'GET /shops', type: :request do
  it 'returns all shops' do
    FactoryBot.create_list(:shop, 10)
    get api_v1_shops_path
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.length).to eq(10)
  end
end

describe 'GET /shop/:id', type: :request do
  it 'returns a specific shop by the shops id' do
    shop = FactoryBot.create(:shop)
    get api_v1_shop_path(shop.id)
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json["id"]).to eq(shop["id"])
  end
end

describe 'POST /shops', type: :request do
  let!(:current_user) { create(:user) }

  before do
    authorization_stub
  end
  it 'creates a new shop' do
    new_shop = {
      name: "Test name",
      address: "Test address",
      phone_number: "Test phone number",
    }
    post api_v1_shops_path, params: new_shop

    expect(response.status).to eq(201)
    expect(Shop.count).to eq(1)

    created_shop = JSON.parse(response.body)

    expect(created_shop['name']).to eq(new_shop[:name])
    expect(created_shop['address']).to eq(new_shop[:address])
    expect(created_shop['phone_number']).to eq(new_shop[:phone_number])
  end
end

describe 'PATCH /shop/:id', type: :request do
  let!(:current_user) { create(:user) }

  before do
    authorization_stub
  end

  it 'updates a shop with new values' do
    updated_shop_data = {
      name: 'Updated Shop Name',
      address: 'Updated Address',
      phone_number: '124-456-7890',
    }
    updated_shop = FactoryBot.create(:shop, updated_shop_data)

    patch api_v1_shop_path(updated_shop.id), params: updated_shop_data

    expect(response.status).to eq(200)

    updated_shop = JSON.parse(response.body)

    expect(updated_shop['name']).to eq(updated_shop_data[:name])
    expect(updated_shop['address']).to eq(updated_shop_data[:address])
    expect(updated_shop['phone_number']).to eq(updated_shop_data[:phone_number])
  end
end

describe 'DELETE /shop/:id', type: :request do
  let!(:current_user) { create(:user) }

  before do
    authorization_stub
  end

  it 'deletes a specific shop' do
    shop = FactoryBot.create(:shop)

    delete api_v1_shop_path(shop.id)

    expect(response.status).to eq(204)
    expect(Shop.count).to eq(0)
  end
end

describe 'GET /api/v1/shops/search', type: :request do
  let!(:current_user) { create(:user) }

  before do
    authorization_stub
  end

  it 'searches for shops with a valid search term' do
    shop1 = create(:shop, name: 'Test Shop 1', address: 'Address 1', access: 'Access 1')
    shop2 = create(:shop, name: 'Test Shop 2', address: 'Address 2', access: 'Access 2')
    create(:shop, name: 'Shop 3', address: 'Address 3', access: 'Access 3')

    search_term = 'Test'

    get '/api/v1/shops/search', params: { search: search_term }

    expect(response.status).to eq(200)

    searched_shops = JSON.parse(response.body)

    expect(searched_shops.length).to eq(2)
    expect(searched_shops[0]['name']).to eq(shop1.name)
    expect(searched_shops[1]['name']).to eq(shop2.name)

    expect(searched_shops[0]['address']).to eq(shop1.address)
    expect(searched_shops[1]['address']).to eq(shop2.address)
    expect(searched_shops[0]['access']).to eq(shop1.access)
    expect(searched_shops[1]['access']).to eq(shop2.access)
  end

  it 'returns all shops when search term is not provided' do
    shop1 = create(:shop)
    shop2 = create(:shop)

    get '/api/v1/shops/search'

    expect(response.status).to eq(200)

    all_shops = JSON.parse(response.body)

    expect(all_shops.length).to eq(2)

    expect(all_shops[0]['name']).to eq(shop1.name)
    expect(all_shops[1]['name']).to eq(shop2.name)
  end
end
