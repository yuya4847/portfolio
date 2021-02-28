require 'rails_helper'

RSpec.describe "Registrations", type: :request do

  describe 'POST #create' do
    let(:user_params) { FactoryBot.attributes_for(:user) }
    let(:invalid_user_params) { FactoryBot.attributes_for(:user, username: "") }

    before do
      ActionMailer::Base.deliveries.clear
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        post user_registration_path, params: { user: user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'リダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it '認証メールが送信されないこと' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end

  describe 'PUT #edit' do
    let(:user) { FactoryBot.create(:user) }
    let(:edit_user) { FactoryBot.build(:user, username: "edit_yuya") }

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        patch user_registration_path, params: { user: edit_user }
        expect(response.status).to eq 302
      end

      it 'usernameが編集されていること' do
        expect do
          patch user_registration_path, params: { user: edit_user }
          binding.pry
        end.to change { User.find(user.id).reload.username }.from('yuya').to('edit_yuya')
      end
    end

    context 'パラメータが不正な場合' do
    end

  end
end
