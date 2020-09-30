require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  
  # describe "GET #home" do
  #   it "returns http success" do
  #     get :home
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  
  describe "GET /" do
    #render_views

    #let(:base_title) { 'Move' }
    
    it "should get root" do
      get '/'
      expect(response).to have_http_status(:success)
      #expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end

end
