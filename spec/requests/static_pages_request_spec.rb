require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe 'GET /' do
    # render_views

    # let(:base_title) { 'Move' }

    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
      # expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end
  
  describe 'GET /about' do
    # render_views

    # let(:base_title) { 'Move' }

    it 'returns http success' do
      get '/about'
      expect(response).to have_http_status(:success)
      # expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end
end
