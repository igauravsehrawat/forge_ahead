require 'spec_helper'

# describe User do

#   before do
#     @user = User.new(name: "Example User", email: "user@example.com")
#     #@user.save #this wasn't used but I did it intentionally to know that actually the test is done on user before saving it into the file.
#   end

#   subject { @user }

#   it { should respond_to(:name) }
#   it { should respond_to(:email) }

#   it { should be_valid }

#   describe "when name is not present" do
#     before { @user.name = " " }
#       it { should_not be_valid }
#   end

#   describe "when email address is already taken" do
#     before do
#       user_with_same_email = @user.dup
#       user_with_same_email.save
#     end

#     it { should_not be_valid }
#   end
  
# end

#user_spec.rb

##password security ..error faced : improper syntax closing resulting
#in unknown variable

describe User do

  before do 
   @user = User.new(name: "Om Nom",email: "omnom@gmail.com",password:"foobar",password_confirmation: "foobar")
  end

subject { @user }
it {should respond_to(:admin) }
it { should respond_to(:microposts) } #that means it should be present

#######these are following -user specs ###
it { should respond_to(:feed)}
it {should respond_to(:relationships)}
it { should respond_to(:followed_users)}

it { should respond_to(:following?)}
it { should respond_to(:follow!) }

describe "following " do

  let(:other_user) { FactoryGirl.create(:user)}
  before do
    @user.save
    @user.follow!(other_user)
  end

  it { should be_following(other_user)}
  its(:followed_users) { should include(other_user)}

  describe "and unfollowing" do

    before {@user.unfollow!(other_user)}
    it { should_not be_following(other_user)}
    its(:followed_users) { should_not include(other_user)}
end

  #subject { @user } #nothing
########end ############
  it{ should respond_to(:name)}
  it{ should respond_to(:email)}
  it{should respond_to(:password_digest)}
  it{ should respond_to(:password)}
  it{ should respond_to(:password_confirmation)}
  it{ should respond_to (:remember_token)}
  it{ should respond_to (:authenticate)}

  it{should be_valid}

  describe "when password is not present" do

    before do
      @user = User.new(name: "Atri Sharma",email: "atri.jiit@gmail.com",password:"",password_confirmation:"")
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

  describe "remember_token" do
    before {@user.save}
    its(:remember_token) {should_not be_blank}
  end
 it { should respond_to(:microposts) }
 it { should respond_to(:feed) }



##micropost association

describe "micropost associations" do
  before { @user.save }
  let!(:older_micropost) do
    FactoryGirl.create(:micropost, user: @user , created_at:  1.day.ago)
  end 
  let!(:newer_micropost) do
    FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago )
  end



  it "should have the right microposts in the right order " do
    expect(@user.microposts.to_a).to eq [newer_micropost,older_micropost]
  end


  describe "status" do
    let(:unfollowed_post) do
      FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
    end

    its(:feed) { should include(newer_micropost)}
    its(:feed) { should include(older_micropost)}
    its(:feed) { should_not include(unfollowed_post)}
  end
  
  it " should destroy associated microposts " do

    microposts = @user.microposts.to_a
    @user.destroy
    expect( microposts).not_to be_empty
    microposts.each do |micropost|
      expect( Micropost.where(id: micropost.id)).to be_empty
    end
  end


end


##move fast

describe "profile page " do
  let(:user) { FactoryGirl.create(:user) }
  let!(:m1) { FactoryGirl.create(:micropost,users: user,content: "Chocobar") }
  let!(:m2) { FactoryGirl.create(:micropost,user: user,content: "Foobar")}

  before { visit user_path(user) }

  it { should have_content(user.name) }
  it { should have_title(user.name) }

  describe "microposts" do
    it { should have_content(m1.content) }
    it { should have_content(m2.content) }
    it { should have_content(user.microposts.count) }
  end
end

end