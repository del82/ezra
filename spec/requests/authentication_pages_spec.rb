require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_selector('title', text: "Sign in") }
  end

  describe "signin" do
    before { visit new_user_session_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-alert', text: 'Invalid login or password') }

      describe "after visiting another page" do
        before { click_link "ezra" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:static) { FactoryGirl.create(:static) }
      before do
        fill_in "Login", with: user.username
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      #it { should have_selector('title', text: user.name) }
      it { should have_link('Sign out', href: destroy_user_session_path, method: "delete") }
      it { should have_link('Targets', href: targets_path) }
      it { should have_link('Features', href: features_path) }
      it { should_not have_link('Sign in', href: new_user_session_path) }

      # static page links
      it { should have_link(static.short_title, href: static_path(static)) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in', href: new_user_session_path) }
      end
    end

    describe "as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        fill_in "Login", with: admin.username
        fill_in "Password", with: admin.password
        click_button "Sign in"
      end
      it { should have_link('Users', href: users_path) }
    end
  end
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Login",    with: user.username
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Update')
          end
        end
      end
    end
  end
end

