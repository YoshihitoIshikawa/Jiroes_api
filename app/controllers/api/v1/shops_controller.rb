class Api::V1::ShopsController < SecuredController
  skip_before_action :authorize_request, only: [:index, :show, :search]

  def index
    @shops = Shop.all
    render json: @shops
  end

  def show
    @shop = Shop.find(params[:id])
    render json: @shop
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      render json: @shop, status: :created
    else
      render json: @shop.errors, status: :unprocessable_entity
    end
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      render json: @shop
    else
      render json: @shop.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
  end

  def search
    if params[:search].present?
      @shops = Shop.where(
        'name LIKE ? OR address LIKE ? OR access LIKE ?',
        "%#{params[:search]}%",
        "%#{params[:search]}%",
        "%#{params[:search]}%"
      )
    else
      @shops = Shop.all
    end
    render json: @shops
  end

  private

  def shop_params
    params.permit(:name, :address, :phone_number, :access, :parking, :number_of_seats, :open_time,
:menu, :closed_days, :remarks, :prohibited_matters, :when_to_buy_tickets, :call_timing, :latitude, :longitude)
  end
end
