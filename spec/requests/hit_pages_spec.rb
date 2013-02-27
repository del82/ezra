require 'spec_helper'
  
describe "Hit pages" do
  subject { page }
  let(:hit) { FactoryGirl.create(:hit) }
  let(:user) { FactoryGirl.create(:user) }

  context "while not signed-in" do
    describe "visit hits_path" do
      before { visit hits_path }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit hits_path" do
      before { visit hits_path(hit) }
      it { should have_selector('title', text: "Sign in") }
    end
    
    describe "visit new_hit_path" do
      before { visit new_hit_path }
      it { should have_selector('title', text: "Sign in") }
      end

    describe "visit edit_hit_path" do
      before { visit edit_hit_path(hit) }
      it { should have_selector('title', text: "Sign in") }
    end
  end 


  context "while signed-in as user" do 
    before do
      visit signin_path
      fill_in "Password", with: user.password
      fill_in "Username", with: user.username
      click_button "Sign in"
    end

    describe "hits index" do
      before { visit hits_path }

     describe "should have the right title" do
        it { should have_selector('title', text: 'Hits') }
      end
    end

    describe "individual hit page" do
      before { visit hit_path(hit) }

      describe "should have the right title" do
        it { should have_selector('title', text: 'Hit '+hit.id.to_s) }
      end
    end

    describe "edit hit page" do
      before { visit edit_hit_path(hit) }

      describe "should have the right title" do
        it { should have_selector('title', text: 'Edit hit '+hit.id.to_s) }
      end
    end
  end
end
