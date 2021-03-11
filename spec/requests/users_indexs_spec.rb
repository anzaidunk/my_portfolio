require 'rails_helper'

RSpec.describe 'UsersIndexs', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  describe 'GET /users' do
    it 'should redirect index when not logged in' do
      get users_path
      follow_redirect!
      expect(request.fullpath).to eq login_path
    end
  end

  describe '#destroy' do
    it 'should redirect destroy when not logged in' do
      expect do
        delete user_path(other_user)
      end.not_to change(User, :count)
      follow_redirect!
      expect(request.fullpath).to eq login_path
    end

    context 'admin' do
      it 'deletes a user' do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get users_path
        expect do
          delete user_path(other_user)
        end.to change(User, :count).by(-1)
        expect(flash[:success]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq users_path
      end
    end

    context 'non-admin' do
      it 'should redirect' do
        log_in_as(other_user)
        expect do
          delete user_path(user)
        end.not_to change(User, :count)
        follow_redirect!
        expect(request.fullpath).to eq root_path
      end
    end
  end
end
