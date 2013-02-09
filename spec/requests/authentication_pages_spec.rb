require 'spec_helper'

describe "Authentication" do

  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('title', text: full_title("Sign in")) }
  end

  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "ezra" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      #it { should have_selector('title', text: user.name) }
      it { should have_link('Sign out', href: signout_path) }
      it { should have_link('Targets'), href: "#" }
      it { should have_link('Features'), href: "#" }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
    describe "as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        fill_in "Username", with: admin.username
        fill_in "Password", with: admin.password
        click_button "Sign in"
      end
      it { should have_link('Users', href: "#") }
    end
  end
end
