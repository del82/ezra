require 'spec_helper'
  
describe "Feature pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }  
  let(:feature) { FactoryGirl.create(:feature) }

  describe "while not signed-in" do
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


  pending "while signed-in" do
    before do
      visit signin_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign in"
    end


    describe "feature index" do
      before { visit features_path }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('All features')) }
      end
    end

    describe "individual feature page" do
      let(:feature) { FactoryGirl.create(:feature) }
      before { visit feature_path(feature) }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('Feature | '+feature.name)) }
      end
    end

    describe "create feature page" do
      before { visit new_feature_path }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('New feature')) }
      end
    end

    describe "edit feature page" do
      let(:feature) { FactoryGirl.create(:feature) }
      before { visit edit_feature_path(feature) }

      describe "should have the right title" do
        it_should_behave_like "all pages"
        it { should have_selector('title', 
                                  text: full_title('Edit | '+feature.name)) }
      end
    end
  end
end
