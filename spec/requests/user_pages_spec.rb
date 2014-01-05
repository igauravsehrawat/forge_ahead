require 'spec_helper'

describe "UserPages" do
  
  subject {page}
 # before { visit signup_path }  random modification doesn't work even in short races

    


   describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, name: "Bob", email: "bob@gmail.com")
       FactoryGirl.create(:user, name: "Ben", email: "ben@gmail.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }
    describe "pagination" do
       before(:all) { 30.times { FactoryGirl.create(:user)} }
       after(:all) { User.delete_all}

       it { should have_selector('div.pagination') }

       it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li' , text:user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }
      describe "as an admin user" do
        let(:admin) { Factory.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete' , href: userpath(User.first)) }
        it "should be able to delete another user" do

          expect do
            click('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

  end
  



  describe describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end


  describe User do
  	before {@user = User.new(name: "Ubuntu pc", email:"ubuntu@canonical.com", password: "falcon123", password_confirmation: "falcon123")}

  	subject {@user}
  	it {should respond_to(:name)} #this means the User.new has the name field
  	it {should respond_to(:email)}#this means the User.new has the email field



  it { should respond_to(:authenticate) }
    it { should respond_to(:admin) }

    it { should be_valid }
    it { should_not be_admin }

    describe "wit hadmin attribute set to 'true' " do 
      before do
        @user.save!
        @user.toggle!(:admin)
      end
     it { should be_admin}
    end
  end

  #look out for scopes
  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}

    before {visit user_path(user)}

    it {should have_content(user.name)}
    it{should have_title(user.name)}
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end


  describe "signup" do

  before {visit signup_path}  
  let(:submit) {"Create my account"}

  describe "with invalid information" do
    it "should not create a user" do
      expect { click_button submit}.not_to change(User,:count) #db and field
    end
  end




  describe "with valid information" do

    before do
      #visit signup_path 
      fill_in "Name" , with: "Ashish Dubey"
      fill_in "Email", with: "ashishdubey91@gmail.com"
      fill_in "Password", with: "mozillaintern"
      fill_in "Confirmation", with: "mozillaintern"
    end

      it "Should create a user" do
        expect { click_button submit}.to change(User,:count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit}
        let(:user) {User.find_by(email: 'ashishdubey91@gmail.com')}

        it { should have_link('Sign out')}
        it { should have_title(user.name)}
        it { should have_selector('div.alert.alert-success', text: 'Welcome')}
      end

  end
end
#common mistakes:: 


      #edit section 
      describe "edit" do
        let(:user) {FactoryGirl.create(:user)}
        before do
          sign_in user
          visit edit_user_path(user)
        end

        describe "page" do
          it {should have_content("Update your profile")}
          it { should have_title("Edit User")}
          it { should have_link('change', href: 'http://gravatar.com/emails')}
        end

        describe "with invalid information" do
          before{ click_button "Save Changes"}
          it {should have_content('error')}
        end

        describe "with valid information" do
          let(:new_name) {"New Name"}
          let(:new_email) {"new@example.com"}

          before do
            fill_in "Name", with: new_name
            fill_in "Email", with: new_email
            fill_in "Password", with: user.password
            fill_in "Confirm Password", with: user.password
            click_button "Save Changes"
          end

          it {should have_title(new_name) }
          it {should have_selector('div.alert.alert-success')}
          it { should have_link('Sign out', href: signout_path)}
          specify { expect(user.reload.name).to eq new_name}
          specify { expect(user.reload.email).to eq new_email}
        end
      end

end

