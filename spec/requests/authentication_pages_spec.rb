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
	end
	

	describe "with valid information" do 
		let(:user) {FactoryGirl.create(:user)}

		#comment
		#for the valid_signin(user))using utilites.rb tweaked for less lines of code


		before { valid_signin(user)} 
		# before do #do -end for multi line code
		# 	fill_in "Email", with: user.email.upcase
		# 	fill_in "Password", with: user.password
		# 	click_button "Sign in"
		# end

		it {should have_title(user.name)}
		it {should have_link('Profile', href:user_path(user))}
		it {should have_link('Sign out', href:signout_path)}
		it { should have_link('Settings', href:edit_user_path(user))}
		it {should_not have_link('Sign in', href: signin_path)}
	end

		describe "with invalid information" do
			before { visit signin_path}
			before {click_button "Sign in"}

			it {should have_title('Sign in')}
			it{ should have_selector('div.alert.alert-error')}

			describe "visiting anothe page" do
				before{ click_link "Home"} 
				it{should_not have_selector('div.alert.alert-error')}
			end


			describe "followed by  signout" do
				before {click_link "Sign out"}
				it { should have_link "Sign in"}
			end
		end


	

	describe "authorization" do
		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }


			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email", with: user.email
					fill_in  "Password", with: user.password
					click_button "Sign in"
					end

					describe "after signing in" do

						it "should render the desired protected page" do
							expect(page).to have_title('Edit User')
						end
					end
				end
				

			describe "in the Users controller" do
				describe "visiting the edit page" do
					before { visit edit_user_path(user)}
					it { should have_title('Sign in')}
				end

				describe "submitting to the update action" do
					before { patch user_path{user}} #getting error of id missing ..ofcourse since it is not logged in
					specify { expect(response).to redirect_to(root_url)}
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user)}
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrongexample@gmail.com")}
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the User" do
				before { get edit_user_path(wrong_user)}
				specify { expect(response.body).not_to match(full_title('Edit User')) }
				specify { expect(response).to redirect_to(root_url)}
			end

			describe "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user)}
				specify { expect(response).to redirect_to(root_url) }
			end
		end



	end
end






