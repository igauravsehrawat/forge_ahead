require 'spec_helper'

describe "Stage" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/stage/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the content 'Home' " do 
    	visit '/stage/home'
    	expect(page).to have_title("Home")
	end

	it "should not have the content ?? the custome one" do 
		visit '/stage/home'		
		expect(page).not_to have_title("! Home")
	end


  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/stage/help'
      expect(page).to have_content('Help')
    end


    it "should have the content 'Home' " do 
    	visit '/stage/help'
    	expect(page).to have_title("Help ")
	end

  end


   describe "Contact us" do 
   	it "should have the location 'Located here' " do
   		visit '/stage/Contact_us'
   		expect(page).to have_content('Located here')
   	end

   	it "should have the content 'Home' " do 
    	visit '/stage/Contact_us'
    	expect(page).to have_title("Contact us")
	end
   end

end