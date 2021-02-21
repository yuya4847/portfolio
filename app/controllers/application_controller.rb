class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
      if current_user
        flash[:notice] = "ログインに成功しました"
        root_url
      else
        flash[:notice] = "新規登録完了しました。次に名前を入力してください"
        root_url
      end
    end

end
