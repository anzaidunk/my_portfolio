require 'rails_helper'

RSpec.describe "SiteLayouts", type: :system do
  
  describe "header layout" do    
    it "contains root link" do
      visit root_path
      expect(page).to have_link 'MOVE', href: root_path
    end

    it "contains signup link" do
      visit root_path
      expect(page).to have_link 'ユーザー登録（無料）', href: signup_path
    end
  end
  
end