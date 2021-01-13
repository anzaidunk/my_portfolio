require 'rails_helper'

RSpec.describe 'SiteLayouts', type: :system do
  describe 'header layout' do
    it 'contains root link' do
      visit root_path
      expect(page).to have_link 'MOVE', href: root_path
    end

    it 'contains signup link' do
      visit root_path
      expect(page).to have_link 'ユーザー登録（無料）', href: signup_path
    end

    it 'contains about link' do
      visit root_path
      expect(page).to have_link 'MOVEとは？', href: about_path
    end

    it 'contains login link' do
      visit root_path
      expect(page).to have_link 'ログイン', href: login_path
    end
  end

  describe 'about layout' do
    it "returns title with 'MOVEとは | MOVE'" do
      visit about_path
      expect(page).to have_title 'MOVEとは | MOVE'
    end
  end
end
