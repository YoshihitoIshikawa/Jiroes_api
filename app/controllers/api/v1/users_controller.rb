require 'auth0'

class Api::V1::UsersController < SecuredController
  skip_before_action :authorize_request, only: [:index, :create]
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    auth0_client = Auth0Client.new(
      client_id: ENV['AUTH0_MANAGEMENT_APP_CLIENT_ID'],
      client_secret: ENV['AUTH0_MANAGEMENT_APP_CLIENT_SECRET'],
      domain: ENV['AUTH0_MANAGEMENT_APP_DOMAIN'],
      scope: 'update:users',
    )

    nickname = params[:nickname]
    sub = params[:sub]

    response = auth0_client.patch_user(sub, { nickname: nickname })

    render json: response
  end

  private

  def user_params
    params.permit(:sub)
  end
end
