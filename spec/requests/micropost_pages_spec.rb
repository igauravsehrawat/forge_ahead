require 'spec_helper'

describe "MicropostPages" do
  
  subject {page}

  let(:user) {FactoryGirl.create(:user) }

  before { sign_in user }

  describe "micropost_creation" do
  	before {visit root_path }

  	describe "with invalid information " do
  		it " should not create micropost" do

  			expect {click_button "Post"}.not_to change(Micropost, :count) #the database and count attribute
  		end

  		describe "error messages" do

  			before { click_button "Post"}
  			it { should have_content('error') }
  		end
  	end


  	describe "with valid information" do
  		before { fill_in 'micropost_content', with: "Lorem ipsum" }
  		it "should create a micropost" do
  			expect { click_button "Post" }.to change(Micropost, :count).by(1)
  		end
  	end
  end
  




end
