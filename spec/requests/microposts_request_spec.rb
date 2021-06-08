require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  def post_invalid_information
    post microposts_path, params: {
      micropost: { content: '' }
    }
  end

  def post_valid_information
    post microposts_path, params: {
      micropost: { content: 'aaa' }
    }
  end

  describe 'POST/micropost' do
    it 'does not add a micropost when not logged in' do
      expect { post_valid_information }.not_to change(Micropost, :count)
      follow_redirect!
      expect(flash[:danger]).to be_truthy
      expect(request.fullpath).to eq '/login'
    end

    it 'does not add a micropost when the content is blank' do
      log_in_as(user)
      get user_path(user)
      expect { post_invalid_information }.not_to change(Micropost, :count)
    end

    it 'succeeded add a micropost' do
      log_in_as(user)
      get user_path(user)
      expect { post_valid_information }.to change(Micropost, :count).by(1)
      follow_redirect!
      expect(flash[:success]).to be_truthy
      expect(request.fullpath).to eq user_path(user)
    end
  end

  describe 'DELETE/micropost' do
    it 'does not delete a micropost when not logged in' do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      first_micropost = user.microposts.paginate(page: 1).first
      delete logout_path
      delete micropost_path(first_micropost)
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/login'
    end

    it 'does not delete a micropost because the user is different' do
      log_in_as(user)
      get user_path(user)
      expect { post_valid_information }.to change(Micropost, :count).by(1)
      follow_redirect!
      first_micropost = user.microposts.paginate(page: 1).first
      delete logout_path
      log_in_as(other_user)
      get user_path(other_user)
      expect { post_valid_information }.to change(Micropost, :count).by(1)
      follow_redirect!
      second_micropost = other_user.microposts.paginate(page: 1).first
      expect { delete micropost_path(second_micropost) }.to change(Micropost, :count).by(-1)
      expect { delete micropost_path(first_micropost) }.not_to change(Micropost, :count)
      follow_redirect!
      expect(request.fullpath).to eq root_path
    end

    it 'succeeded delete a micropost' do
      log_in_as(user)
      get user_path(user)
      expect { post_valid_information }.to change(Micropost, :count).by(1)
      follow_redirect!
      first_micropost = user.microposts.paginate(page: 1).first
      expect { delete micropost_path(first_micropost) }.to change(Micropost, :count).by(-1)
      follow_redirect!
      expect(flash[:success]).to be_truthy
      expect(request.fullpath).to eq user_path(user)
    end
  end
end
