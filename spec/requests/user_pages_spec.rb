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
end
