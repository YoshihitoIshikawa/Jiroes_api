module AuthenticationHelper
  def authorization_stub
    allow_any_instance_of(SecuredController).to receive(:authorize_request).and_return(@current_user)
  end
end
