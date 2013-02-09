require 'spec_helper'
require 'requests/all_pages'
  
describe "Feature pages" do
  subject { page }

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
