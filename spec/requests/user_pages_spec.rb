require 'spec_helper'
require 'requests/all_pages'
  
describe "User pages" do
  subject { page }

  describe "user index" do
    before { visit users_path }

    describe "should have the right title" do
      it_should_behave_like "all pages"
      it { should have_selector('title', 
                                text: full_title('All users')) }
    end
  end

  describe "individual user page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    describe "should have the right title" do
      it_should_behave_like "all pages"
      it { should have_selector('title', 
                                text: full_title('User | '+user.username)) }
    end
  end

  describe "create user page" do
    before { visit new_user_path }

    describe "should have the right title" do
      it_should_behave_like "all pages"
      it { should have_selector('title', 
                                text: full_title('New user')) }
    end
  end

  describe "edit user page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "should have the right title" do
      it_should_behave_like "all pages"
      it { should have_selector('title', 
                                text: full_title('Edit | '+user.username)) }
    end
  end

  describe "create user" do
    before { visit new_user_path }
    
    let(:submit) { "Create user" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        
        it { should have_selector('title', text: 'New user') }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Full Name",      with: "Example User"
        fill_in "Username",       with: "exampleuser"
        fill_in "Email",          with: "user@example.com"
        fill_in "Password",       with: "foobar"
        fill_in "Confirmation",   with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
