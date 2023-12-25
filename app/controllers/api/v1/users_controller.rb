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

    sub = params[:sub]
    user_data = {}

    if params[:nickname].present?
      user_data[:nickname] = params[:nickname]
    end

    if params[:email].present?
      user_data[:email] = params[:email]
    end

    if params[:picture].present?
      if Rails.env.production?
        user = User.find_by(sub: sub)
        user.picture = params[:picture]
        user.save!

        picture_url = user.picture.url
      else
        render json: { error: 'この操作は開発環境では実行できません。' }, status: :unprocessable_entity
        return
      end

      user_data[:picture] = picture_url
    end

    response = auth0_client.patch_user(sub, user_data)

    render json: response
  end

  private

  def user_params
    params.permit(:sub)
  end
end
