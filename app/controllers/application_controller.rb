class ApplicationController < ActionController::API
  before_action :authenticate_from_token!, except: [:options]

  def authenticate_from_token!
    auth_header = request.headers['HTTP_AUTHORIZATION']
    token_str, _options = ActionController::HttpAuthentication::Token.token_and_options(request)
    render(json: {}, status: 401) && return if token_str.nil?

    token = JwtAuth::Coder.new.decode(token_str)
    render(json: {}, status: 401) && return if token.nil? || token.expired?

    @current_user = User.find_by(id: token.user_id)

    return unless @current_user.nil?
    render json: {}, status: 401
  end
end
