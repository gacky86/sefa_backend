class ApplicationController < ActionController::Base
  # classの継承元をAPI->Baseに変更して下記のエラーを回避
  # Before process_action callback :verify_authenticity_token has not been defined
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token
  helper_method :current_user, :user_signed_in?
end
