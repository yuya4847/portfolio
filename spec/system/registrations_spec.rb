require 'rails_helper'
RSpec.describe "Registrations", type: :system do

    describe '#create' do
      it '新規登録画面の要素検証すること' do
        visit '/users/sign_up'
        expect(page).to have_selector 'span', text: '※必須', count: 4
        expect(page).to have_selector 'label', text: 'Username'
        expect(page).to have_selector 'label', text: 'メールアドレス'
        expect(page).to have_selector 'label', text: 'Profile'
        expect(page).to have_selector 'label', text: '性別'
        expect(page).to have_selector 'label', text: 'パスワード'
        expect(page).to have_selector 'label', text: 'パスワード(確認用）'
        expect(page).to have_selector 'input', class: 'username_form'
        expect(page).to have_selector 'input', class: 'email_form'
        expect(page).to have_selector 'textarea', class: 'profile_area'
        expect(page).to have_selector 'input', class: 'sex_man_form'
        expect(page).to have_selector 'input', class: 'sex_woman_form'
        expect(page).to have_selector 'input', class: 'password_form'
        expect(page).to have_selector 'input', class: 'password_confirmation_form'
        expect(page).to have_button 'Sign up'
        expect(page).to have_link 'ログインする'
        expect(page).to have_link 'アカウント有効化のメールが届いていない方'
      end

      it '各入力欄に適切な値が入力されていない新規登録を許可しないこと' do
        visit '/users/sign_up'
        click_button 'Sign up'
        within('.error_message') do
          expect(page).to have_content '以下のエラーにより、保存されませんでした。'
        end
        within('.error_messages') do
          expect(page).to have_content 'Usernameを入力してください'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(page).to have_content 'メールアドレスは不正な値です'
          expect(page).to have_content 'パスワードを入力してください'
          expect(page).to have_content 'パスワードは6文字以上で入力してください'
        end
      end

      it 'username,email,passwordが全て正しい場合、新規登録が可能であること' do
        @user = build(:user)
        visit '/users/sign_up'
        fill_in 'user_username', with: @user.username
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        fill_in 'user_password_confirmation', with: @user.password_confirmation
        click_button 'Sign up'
        within('.notice') do
          expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        end
      end
    end

    describe '#edit' do
      before do
        @user = create(:user)
      end

      it 'プロフィール編集画面の要素検証すること' do
        visit '/users/sign_in'
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        click_button 'ログイン'
        within('.notice') do
          expect(page).to have_content 'ログインしました'
        end
        visit '/users/edit'
        expect(page).to have_selector 'label', text: 'Username'
        expect(page).to have_selector 'label', text: 'メールアドレス'
        expect(page).to have_selector 'label', text: 'Profile'
        expect(page).to have_selector 'label', text: 'パスワード'
        expect(page).to have_selector 'label', text: 'パスワード(確認用）'
        expect(page).to have_selector 'input', class: 'username_form'
        expect(page).to have_selector 'input', class: 'email_form'
        expect(page).to have_selector 'textarea', class: 'profile_area'
        expect(page).to have_selector 'input', class: 'password_form'
        expect(page).to have_selector 'input', class: 'password_confirmation_form'
        expect(page).to have_button 'Update'
        expect(page).to have_button 'Cancel my account'
        expect(page).to have_link 'Back'
      end

      it '適切なusernameだけ入力し編集完了できること' do
        visit '/users/sign_in'
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        click_button 'ログイン'
        within('.notice') do
          expect(page).to have_content 'ログインしました'
        end
        visit '/users/edit'
        fill_in 'user_username', with: "edit_user"
        fill_in 'user_password', with: ""
        fill_in 'user_password_confirmation', with: ""
        click_button 'Update'
        expect(current_path).to eq root_path
        expect(page).to have_content 'edit_user'
        expect(page).not_to have_content 'ようこそ'
        within('.notice') do
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
      end

      it 'username,passwordを適切な値が入力され編集完了できること' do
        visit '/users/sign_in'
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        click_button 'ログイン'
        within('.notice') do
          expect(page).to have_content 'ログインしました'
        end
        visit '/users/edit'
        fill_in 'user_username', with: "edit_user"
        fill_in 'user_password', with: "edit_password"
        fill_in 'user_password_confirmation', with: "edit_password"
        click_button 'Update'
        expect(current_path).to eq root_path
        expect(page).not_to have_content 'edit_user'
        expect(page).to have_content 'ようこそ'
        within('.notice') do
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
      end

      it 'username,emailを適切な値が入力され編集完了できること' do
        visit '/users/sign_in'
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        click_button 'ログイン'
        within('.notice') do
          expect(page).to have_content 'ログインしました'
        end
        visit '/users/edit'
        fill_in 'user_username', with: "edit_user"
        fill_in 'user_email', with: "edituser@example.com"
        click_button 'Update'
        expect(current_path).to eq root_path
        expect(page).to have_content 'edit_user'
        expect(page).not_to have_content 'ようこそ'
        within('.notice') do
          expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'
        end
      end
    end
end
