require 'rails_helper'

RSpec.describe 'SiteLayouts', type: :system do
  let(:user) {create(:user)}
  
  def submit_with_valid_information(remember_me = 0)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    check 'session_remember_me' if remember_me == 1
    find('.btn').click
  end
  
  describe 'header layout' do
    it 'contains root link' do
      visit root_path
      expect(page).to have_link 'MOVE', href: root_path
    end
    
    it 'contains about link' do
      visit root_path
      expect(page).to have_link 'MOVEとは？', href: about_path
    end

    context 'when user not login' do
      it 'contains signup link' do
        visit root_path
        expect(page).to have_link 'ユーザー登録（無料）', href: signup_path
      end
  
      it 'contains login link' do
        visit root_path
        expect(page).to have_link 'ログイン', href: login_path
      end
    end  
    
    context 'when user login' do
      it 'contains index link' do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(user)
        expect(page).to have_link 'ユーザー一覧', href: users_path
      end
      
      it 'contains show link' do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(user)
        expect(page).to have_link 'プロフィール', href: user_path(user)
      end
      
      it 'contains edit link' do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(user)
        expect(page).to have_link '編集', href: edit_user_path(user)
      end
      
      it 'contains logout link' do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(user)
        expect(page).to have_link 'ログアウト', href: logout_path
      end
    end
  end

  describe 'about layout' do
    it "returns title with 'MOVEとは | MOVE'" do
      visit about_path
      expect(page).to have_title 'MOVEとは | MOVE'
    end
  end
end
