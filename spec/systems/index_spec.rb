require 'rails_helper'

RSpec.describe 'Indexes', type: :system do
  
  let(:user) {create(:user)}
  let(:other_user) { create(:other_user) }
  
  def submit_with_admin_information(remember_me = 0)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    check 'session_remember_me' if remember_me == 1
    find('.btn').click
  end
  
  def submit_with_non_admin_information(remember_me = 0)
    fill_in 'メールアドレス', with: other_user.email
    fill_in 'パスワード', with: other_user.password
    check 'session_remember_me' if remember_me == 1
    find('.btn').click
  end

  context 'admin' do
    it 'including pagination and delete links' do
      visit login_path
      submit_with_admin_information
      expect(current_path).to eq user_path(user)
      click_link 'ユーザー一覧'
      expect(current_path).to eq users_path
      expect(page).to have_selector '.pagination', count:2
      User.paginate(page: 1).each do |user|
          expect(page).to have_link user.name, href: user_path(user)
      end
      expect(page).to have_link '削除', href: user_path(User.first)
      expect(page).to have_link '削除', href: user_path(User.second)
      click_on '2', match: :first
      expect(page).not_to have_link '削除', href: user_path(user)
      expect {
        page.accept_confirm('本当によろしいでしょうか?') do
          click_link :削除, match: :first
        end
        expect(page).to have_content 'ユーザーを削除しました'
      }.to change(User, :count).by(-1)
      expect(current_path).to eq users_path
    end
  end
  
  context 'non-admin' do
    it 'not including delete links' do
      visit login_path
      submit_with_non_admin_information
      expect(current_path).to eq user_path(other_user)
      click_link 'ユーザー一覧'
      expect(current_path).to eq users_path
      expect(page).to have_selector '.pagination', count:2
      User.paginate(page: 1).each do |user|
          expect(page).to have_link user.name, href: user_path(user)
      end
      expect(page).not_to have_link '削除', href: user_path(User.first)
      expect(page).not_to have_link '削除', href: user_path(User.second)
      expect {
        delete user_path(User.first)
      }.to change(User, :count).by(0)
    end
  end
    
end