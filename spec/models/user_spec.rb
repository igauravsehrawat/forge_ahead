require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com")
    #@user.save #this wasn't used but I did it intentionally to know that actually the test is done on user before saving it into the file.
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
      it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
end

#user_spec.rb

##password security ..error faced : improper syntax closing resulting
#in unknown variable

describe User do

  before do 
   @user = User.new(name: "Om Nom",email: "omnom@gmail.com",password:"foobar",password_confirmation: "foobar")
  end


  #subject { @user }

  it{ should respond_to(:name)}
  it{ should respond_to(:email)}
  it{should respond_to(:password_digest)}
  it{ should respond_to(:password)}
  it{ should respond_to(:password_confirmation)}

  it{should be_valid}

  describe "when password is not present" do

    before do
      @user = User.new(name: "Om Nom",email: "omnom@gmail.com",password:"",password_confirmation:"")
    end
      it{should_not be_valid}
  end

  describe "when password mismatches" do
    before { @user.password_confirmation="mismatch"}
      it{should_not be_valid}
  end


  describe "password is short ! fix it" do
    before {@user.password=@user.password_confirmation="a"*5}
    it {should be_invalid}
  end

  describe "return value of authenticate method" do
    before {@user.save}
    let(:found_user) {User.find_by(email: @user.email)}

    describe "with valid password" do
      it {should eq found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:invalid_password_user) {found_user.authenticate("scoobydobydoo")}

      it { should_not eq invalid_password_user}
      specify { expect(user_for_invalid_password.to be_false)}
    end
  end



end