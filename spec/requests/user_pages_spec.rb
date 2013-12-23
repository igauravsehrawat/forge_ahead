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

end

