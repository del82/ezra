require 'spec_helper'
require 'requests/all_pages'
  
describe "Target pages" do
  subject { page }

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
                                text: full_title('Target | '+target.target_string)) }
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
                                text: full_title('Edit | '+target.target_string)) }
    end
  end
end
