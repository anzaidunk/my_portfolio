require 'rails_helper'

RSpec.describe 'Logins', type: :system do
  
  let(:user) {create(:user)}

  def submit_with_invalid_information
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    find('.btn').click
  end

  def submit_with_valid_information(remember_me = 0)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    check 'session_remember_me' if remember_me == 1
    find('.btn').click
  end

  describe 'Login' do
    context 'login with invalid information' do
      it 'is failure' do
        visit login_path
        expect(page).to have_content 'ユーザー登録されていない方はこちら'
        submit_with_invalid_information
        expect(current_path).to eq login_path
        expect(page).to have_selector '.alert-danger'
      end

      it 'delete flash when users move to other pages' do
        visit login_path
        submit_with_invalid_information
        expect(current_path).to eq login_path
        visit root_path
        expect(page).not_to have_selector '.alert-danger'
      end
    end

    context 'login with valid information' do
      it 'is success' do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(user)
        expect(page).not_to have_selector '.alert-danger'
      end

      it 'contains logout button without login button' do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(user)
        expect(page).not_to have_button 'ログイン'
        expect(page).to have_button 'ログアウト'
      end
    end
  end

  describe 'Logout' do
    it 'contains login button without logout button' do
      visit login_path
      submit_with_valid_information
      expect(current_path).to eq user_path(user)
      expect(page).not_to have_button 'ログイン'
      expect(page).to have_button 'ログアウト'
      click_button 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_content '【採用担当者様　専用ログインフォーム】'
      expect(page).to have_button 'ログイン'
      expect(page).not_to have_button 'ログアウト'
    end
  end
end
