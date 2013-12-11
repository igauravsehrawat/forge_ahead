require 'spec_helper'

describe "Stage" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/stage/home'
      expect(page).to have_content('Sample App')
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/stage/help'
      expect(page).to have_content('Help')
    end
  end


   describe "Contact us" do 
   	it "should have the location 'Located here' " do
   		visit '/stage/Contact_us'
   		expect(page).to have_content('Located here')
   	end
   end

end