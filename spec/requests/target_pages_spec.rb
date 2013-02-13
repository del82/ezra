require 'spec_helper'
require 'requests/all_pages'
  
describe "Target pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }  
  let(:target) { FactoryGirl.create(:target) }
  
  describe "while not signed-in" do
    describe "visit targets_path" do
      before { visit targets_path }
      it { should have_selector('title', text: "Sign in") }        
    end

    describe "visit target_path" do
      before { visit target_path(target) }
      it { should have_selector('title', text: "Sign in") }
    end
    
    describe "visit new_target_path" do
      before { visit new_target_path }
      it { should have_selector('title', text: "Sign in") }
      end

    describe "visit edit_target_path" do
      before { visit edit_target_path(target) }
      it { should have_selector('title', text: "Sign in") }
    end

  end

  pending "while signed-in" do 
    before do
      visit signin_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    describe "target index" do
      before { visit targets_path }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('All targets')) }
      end
    end

    describe "individual target page" do
      let(:target) { FactoryGirl.create(:target) }
      before { visit target_path(target) }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('Target | '+target.phrase)) }
      end
    end

    describe "create target page" do
      before { visit new_target_path }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('New target')) }
      end
    end

    describe "edit target page" do
      let(:target) { FactoryGirl.create(:target) }
      before { visit edit_target_path(target) }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('Edit | '+target.phrase)) }
      end
    end
  end
end
