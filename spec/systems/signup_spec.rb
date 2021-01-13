require 'rails_helper'

RSpec.describe 'Signups', type: :system do
  def submit_with_invalid_information
    fill_in '名前 （最大５０文字）', with: ''
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード （最小６文字）', with: 'foo'
    fill_in 'パスワード （再入力）', with: 'bar'
    find('.btn').click
  end

  def submit_with_valid_information
    fill_in '名前 （最大５０文字）', with: 'Example User'
    fill_in 'メールアドレス', with: 'user@example.com'
    fill_in 'パスワード （最小６文字）', with: 'password'
    fill_in 'パスワード （再入力）', with: 'password'
    find('.btn').click
  end

  it 'is failure by an invalid input data' do
    visit signup_path
    submit_with_invalid_information
    expect(current_path).to eq signup_path
    expect(page).to have_selector '#error_explanation'
    expect(page).to have_button 'ログイン'
    expect(page).not_to have_button 'ログアウト'
  end

  it 'is success by an valid input data' do
    visit signup_path
    expect { submit_with_valid_information }.to change(User, :count).by(1)
    expect(current_path).to eq user_path(User.last)
    expect(page).not_to have_selector '#error_explanation'
    expect(page).to have_content 'ＭＯＶＥへようこそ'
    expect(page).not_to have_button 'ログイン'
    expect(page).to have_button 'ログアウト'
  end
end
