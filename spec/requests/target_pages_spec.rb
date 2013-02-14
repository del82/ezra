require 'spec_helper'
  
describe "Target pages" do
  subject { page }
  
  context "while not signed-in" do
    let(:user) { FactoryGirl.create(:user) }  
    let(:target) { FactoryGirl.create(:target) }

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

  context "while signed-in as user" do
    let(:user) { FactoryGirl.create(:user) }  
    let(:target) { FactoryGirl.create(:target) }

    before do
      visit signin_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    describe "target index" do
      before { visit targets_path }

      describe "should allow access and have the right title" do
        it { should have_selector('title', text: 'Targets') }
      end
    end

    describe "individual target page" do
      before { visit target_path(target) }

      describe "should have the right title" do
        it { should have_selector('title', text: target.phrase) }
      end
    end

    describe "create target page" do
      before { visit new_target_path }

      describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end

    describe "edit target page" do
      let(:target) { FactoryGirl.create(:target) }
      before { visit edit_target_path(target) }

      describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end
  end

  context "while signed-in as admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:target) { FactoryGirl.create(:target) }


    before do
      visit signin_path
      fill_in "Password", with: admin.password
      fill_in "Username", with: admin.username
      click_button "Sign in"
    end

    describe "visiting target index" do
      before { visit targets_path }

      describe "should have the right title" do
        it { should have_selector('title', text: 'Targets') }
      end
    end
      
    describe "individual target page" do
      before { visit target_path(target) }
      
      describe "should have the right title" do
        it { should have_selector('title', text: target.phrase) }
      end
    end

    describe "create target page" do
      before { visit new_target_path } 
      
      describe "should have the right title" do
        it { should have_selector('title', text: 'New target' ) }
      end
    end

    describe "edit target page" do
      before { visit edit_target_path(target) }
      describe "should have the right title" do
        it { should have_selector('title', text: 'Edit "' + target.phrase + '"') }
      end
    end
  end
end
