require 'rails_helper'
RSpec.describe "Sessions", type: :system do
  describe "商品詳細ページの表示" do
    before do
        @user = create(:user)
    end

    it 'ログインページの要素検証' do
      visit 'users/sign_in'

      expect(page).to have_link 'サインアップする'
      expect(page).to have_link 'パスワードを忘れた方'
      expect(page).to have_link 'アカウント有効化のメールが届いていない方'
    end
  end
end
