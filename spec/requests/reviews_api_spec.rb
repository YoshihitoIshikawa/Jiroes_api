require 'rails_helper'

describe 'Api::V1::ReviewsController', type: :request do
  let!(:current_user) { create(:user) }
  let!(:shop) { create(:shop) }
  let!(:reviews) { create_list(:review, 5, shop: shop, sub: current_user.sub) }

  before do
    authorization_stub
  end

  describe 'GET /api/v1/shops/:shop_id/reviews' do
    it 'returns all reviews for a shop' do
      get api_v1_shop_reviews_path(shop.id)

      expect(response.status).to eq(200)

      reviews_json = JSON.parse(response.body)
      expect(reviews_json.length).to eq(5)
    end
  end

  describe 'POST /api/v1/reviews with image' do
    it 'creates a new review' do
      review_params = {
        title: 'Test Review',
        caption: 'This is a test review.',
        score: 5,
        sub: current_user.sub,
        shop_id: shop.id,
        image: fixture_file_upload('test.png', 'image/png'),
      }

      post api_v1_shop_reviews_path(shop.id), params: review_params

      expect(response.status).to eq(201)

      new_review = JSON.parse(response.body)
      expect(new_review['title']).to eq(review_params[:title])
      expect(new_review['caption']).to eq(review_params[:caption])
      expect(new_review['score']).to eq(review_params[:score])
      expect(new_review['image']['url']).to include('uploads/')
    end
  end

  describe 'GET /api/v1/reviews/:id' do
    it 'returns a specific review by the review id' do
      review = FactoryBot.create(:review, sub: current_user.sub, shop_id: shop.id)
      get api_v1_shop_review_path(shop.id, review.id)
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json["id"]).to eq(review["id"])
    end
  end

  describe 'PATCH /api/v1/reviews/:id with updated image' do
    it 'updates a review with new value' do
      updated_params = {
        title: 'Updated Title',
        caption: 'Updated caption',
        score: 5,
        sub: current_user.sub,
        shop_id: shop.id,
        image: fixture_file_upload('test.png', 'image/png'),
      }
      review = FactoryBot.create(:review, updated_params)

      patch api_v1_shop_review_path(shop.id, review.id), params: updated_params

      expect(response.status).to eq(200)

      updated_review = JSON.parse(response.body)
      expect(updated_review['title']).to eq(updated_params[:title])
      expect(updated_review['caption']).to eq(updated_params[:caption])
      expect(updated_review['score']).to eq(updated_params[:score])
      expect(updated_review['image']['url']).to include('uploads/')
    end
  end

  describe 'DELETE /api/v1/reviews/:id' do
    it 'deletes a review' do
      review = FactoryBot.create(:review, sub: current_user.sub, shop_id: shop.id)

      delete api_v1_shop_review_path(shop.id, review.id)

      expect(response.status).to eq(200)
    end
  end
end
