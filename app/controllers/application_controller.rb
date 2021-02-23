class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログイン後に遷移するpathを設定
  def after_sign_in_path_for(resource)
      if current_user
        flash[:notice] = "ログインに成功しました"
        root_url
      else
        flash[:notice] = "新規登録完了しました。次に名前を入力してください"
        root_url
      end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :profile, :sex])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :emai, :profile, :sex, :password])
    end

end
