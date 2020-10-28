require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  
  it "is failure by an invalid input data" do
    visit signup_path
    fill_in '名前 （最大５０文字）',     with: ''
    fill_in 'メールアドレス',            with: 'user@invalid'
    fill_in 'パスワード （最小６文字）', with: 'foo'
    fill_in 'パスワード （再入力）',     with: 'bar'
    click_on 'ユーザー登録'
    expect(page).to have_selector '#error_explanation'
    expect(current_path).to eq signup_path
  end
  
  it "is success by an valid input data" do
    visit signup_path
    fill_in '名前 （最大５０文字）',     with: 'Example User'
    fill_in 'メールアドレス',            with: 'user@example.com'
    fill_in 'パスワード （最小６文字）', with: 'password'
    fill_in 'パスワード （再入力）',     with: 'password'
    click_on 'ユーザー登録'
    expect(page).not_to have_selector '#error_explanation'
    # expect(current_path).to eq user_path()
    expect(page).to have_content 'ＭＯＶＥへようこそ'
  end
  
end