require 'rails_helper'

RSpec.describe Micropost, type: :model do
  # let(:user) { create(:user) }
  # let(:micropost) { user.microposts.build(content: "Lorem ipsum", user_id: user.id) }
  # let(:micropost) { user.microposts.build(content: "Lorem ipsum") }
  let!(:microposts) { create(:microposts, :micropost_1) }

  describe 'Micropost' do
    it 'should be valid' do
      expect(microposts).to be_valid
    end

    it 'should be most recent first' do
      # create(:microposts, :micropost_1)
      create(:microposts, :micropost_2)
      create(:microposts, :micropost_3)
      micropost_4 = create(:microposts, :micropost_4)
      expect(Micropost.first).to eq micropost_4
    end
  end

  describe 'content' do
    it 'content should be present' do
      microposts.content = '   '
      expect(microposts).to be_invalid
    end

    it 'should not be at most 255 characters' do
      microposts.content = 'a' * 255
      expect(microposts).to be_valid
      microposts.content = 'a' * 256
      expect(microposts).to be_invalid
    end
  end

  describe 'user_id' do
    it 'should be present' do
      microposts.user_id = nil
      expect(microposts).to be_invalid
    end
  end
end
