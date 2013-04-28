require 'spec_helper'

describe "Feature pages" do
  subject { page }

  context "while not signed-in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:feature) { FactoryGirl.create(:feature) }

    describe "visit features_path" do
      before { visit features_path }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit feature_path" do
      before { visit feature_path(feature) }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit new_feature_path" do
      before { visit new_feature_path }
      it { should have_selector('title', text: "Sign in") }
      end

    describe "visit edit_feature_path" do
      before { visit edit_feature_path(feature) }
      it { should have_selector('title', text: "Sign in") }
    end
  end


  context "while signed-in as user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:feature) { FactoryGirl.create(:feature) }
    before do
      visit new_user_session_path
      fill_in "Login", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    describe "feature index" do
      before { visit features_path }

      describe "should allow access and have the right title" do
        it { should have_selector('title', text: 'Features') }
      end
    end

    describe "individual feature page" do
      before { visit feature_path(feature) }

      describe "should have the right title" do
        it { should have_selector('title', text: feature.name) }
      end
    end

    describe "create feature page" do
      before { visit new_feature_path }

      describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end

    describe "edit feature page" do
      let(:feature) { FactoryGirl.create(:feature) }
      before { visit edit_feature_path(feature) }

      describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end
  end

  context "while signed-in as admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:feature) { FactoryGirl.create(:feature) }

    before do
      visit new_user_session_path
      fill_in "Password", with: admin.password
      fill_in "Login", with: admin.username
      click_button "Sign in"
    end

    describe "visiting feature index" do
      before { visit features_path }

      describe "should have the right title" do
        it { should have_selector('title', text: 'Features') }
      end
    end

    describe "individual feature page" do
      before { visit feature_path(feature) }

      describe "should have the right title" do
        it { should have_selector('title', text: feature.name) }
      end
    end

    describe "create feature page" do
      before { visit new_feature_path }

      describe "should have the right title" do
        it { should have_selector('title', text: 'New feature' ) }
      end
    end

    describe "edit feature page" do
      before { visit edit_feature_path(feature) }
      describe "should have the right title" do
        it { should have_selector('title', text: 'Edit "' + feature.name + '"') }
      end
    end
  end
end
