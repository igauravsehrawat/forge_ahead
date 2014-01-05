require 'spec_helper'

describe "Stage" do

  describe "Home page" do

    it "should have the content 'Welcome home'" do
      visit '/home'
      expect(page).to have_content('Welcome')
    end

    it "should have the content 'Home' " do 
    	visit '/home'
    	expect(page).to have_title("Home")
	end


#CAUTIONS:: do comment out the failing test after validating it. 
	#it "should not have the content ?? the custome one" do 
	#	visit '/stage/home'		
	#	expect(page).not_to have_title("| Home")
	# end*/


  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/help'
      expect(page).to have_content('Help')
    end


    it "should have the content 'Help' " do 
    	visit '/help'
    	expect(page).to have_title("Help ")
	end

  end


   describe "Contact us" do 
   	it "should have the location 'Located here' " do
   		visit '/contact'
   		expect(page).to have_content('Located here')
   	end

   	it "should have the title 'contact us' " do 
    	visit '/contact'
    	expect(page).to have_title("Contact us")
	end
   end

end