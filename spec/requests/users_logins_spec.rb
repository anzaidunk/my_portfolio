require 'rails_helper'

RSpec.describe 'UsersLogins', type: :request do
  include SessionsHelper

  let(:user) { create(:user) }

  def post_invalid_information
    post login_path, params: {
      session: {
        email: '',
        password: ''
      }
    }
  end

  def post_valid_information(remember_me = 0)
    post login_path, params: {
      session: {
        email: user.email,
        password: user.password,
        remember_me: remember_me
      }
    }
  end

  describe 'GET /login' do
    context 'is invalid login information' do
      it 'has a danger flash message' do
        get login_path
        post_invalid_information
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
      end
    end

    context 'is valid login information' do
      it 'has no danger flash message' do
        get login_path
        post_valid_information
        expect(flash[:danger]).to be_falsey
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq user_path(user)
      end

      it 'login and logout' do
        get login_path
        post_valid_information
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq user_path(user)
        delete logout_path
        expect(is_logged_in?).to be_falsey
        follow_redirect!
        expect(request.fullpath).to eq root_path
      end

      it 'does not log out twice' do
        get login_path
        post_valid_information
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq user_path(user)
        delete logout_path
        expect(is_logged_in?).to be_falsey
        follow_redirect!
        expect(request.fullpath).to eq root_path
        delete logout_path
        follow_redirect!
        expect(request.fullpath).to eq root_path
      end

      it 'succeeds remember_token because of check remember_me' do
        get login_path
        post_valid_information(1)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).not_to be_nil
      end

      it 'has no remember_token because of check remember_me' do
        get login_path
        post_valid_information(0)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).to be_nil
      end

      it 'has no remember_token when users logged out and logged in' do
        get login_path
        post_valid_information(1)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).not_to be_empty
        delete logout_path
        expect(is_logged_in?).to be_falsey
        expect(cookies[:remember_token]).to be_empty
      end
    end
  end
end
