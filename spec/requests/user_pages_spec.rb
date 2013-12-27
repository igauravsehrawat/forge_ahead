require 'spec_helper'

describe "UserPages" do
  
  subject {page}
  describe describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end


  describe User do
  	before {@user = User.new(name: "Ubuntu pc", email:"ubuntu@canonical.com")}

  	subject {@user}
  	it {should respond_to(:name)} #this means the User.new has the name field
  	it {should respond_to(:email)}#this means the User.new has the email field
  end

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}

    before {visit user_path(user)}

    it {should have_content(user.name)}
    it{should have_title(user.name)}
  end

  describe "signup page" do

  before {visit signup path}  
  let(:submit) {"create my account"}

  describe "with invalid information" do
    it "should not create a user" do
      expect { click_button submit}.not_to change(User,:count) #db and field
    end
  end
end

  describe "with valid information" do
    before do 
      fill_in "Name" , with: "Ashish Dubey"
      fill_in "Email", with: "ashishdubey91@gmail.com"
      fill_in "password", with: "mozillaintern"
      fill_in "Confirmation", with: "mozillaintern"
    end

      it "Should create a user" do
        expect {click_button submit}.to change(User,:count).by(1)
      end

  end






end

