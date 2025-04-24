# アカウント作成用コントローラー
# 継承元も変更するので注意
class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    # 下記のstrong paramsはメール認証時のトライで書いたものだが、うまくいかなかったため、コメントアウト
    # params.require(:registration).permit(:email, :password, :password_confirmation, :name)
    params.permit(:email, :password, :password_confirmation, :name)
  end
end
