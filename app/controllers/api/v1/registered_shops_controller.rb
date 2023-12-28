class Api::V1::RegisteredShopsController < SecuredController
  def index
    shops = Shop.where(sub: @current_user.sub).order(created_at: :desc)
    render json: shops
  end
end
