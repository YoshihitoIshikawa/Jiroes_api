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
    token = request.headers['Authorization']
    nickname = params[:nickname]

    response = HTTParty.patch(
      "#{ENV['AUTH0_DOMAIN']}api/v2/users/#{@current_user.sub}",
      body: { nickname: nickname }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => token
      }
    )

    render json: response.body, status: response.code
  end

  private

  def user_params
    params.permit(:sub)
  end
end
