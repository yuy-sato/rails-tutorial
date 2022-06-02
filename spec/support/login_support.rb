module LoginSupport
  module Request
    def log_in(user)
      post login_path, params: { session: { email: user.email, password: user.password } }
    end
 
    def logged_in?
      !session[:user_id].nil?
    end
  end
end

RSpec.configure do |config|
  config.include LoginSupport::Request, type: :request
end