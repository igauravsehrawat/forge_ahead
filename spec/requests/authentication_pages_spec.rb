require 'spec_helper'

describe "AuthenticationPages" do
  describe "GET /signin_path" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get signin_path
      response.status.should be(200)
    end
  end
end

describe "Authentication" do
	subject {page}

describe "signin" do
		before {visit signin_path}

		it {should have_content('Sign in') }
		it { should have_title('Sign in') }
	

	describe "with valid information" do 
		let(:user) {FactoryGirl.create(:user)}

		before do #do -end for multi line code
			fill_in "Email", with: user.email.upcase
			fill_in "Password", with: user.password
			click_button "Sign in"
		end

		it {should have_title(user.name)}
		it {should have_link('Profile', href:user_path(user))}
		it {should have_link('Sign out', href:signout_path)}
		it {should_not have_link('Sign in', href: signin_path)}

		describe "with invalid information" do
			before {click_button "Sign in"}

			it {should have_title('Sign in')}
			it{ should have_selector('div.alert.alert-error')}

			describe "visiting anothe page" do
				before{ click_link "Home"} 
				it{should_not have_selector('div.alert.alert-error')}
			end
		end


		describe "followed by  signout" do
			before {click_link "Sign out"}
			it { should have_link "Sign in"}
		end
		
	end
 end
end






