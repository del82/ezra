require 'spec_helper'

describe "Static pages" do

  subject { page }


  describe "Home page" do
    before { visit root_path }
    
    it { should have_selector 'title', text: full_title('') }
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "About page" do
    before { visit about_path }
    
    it { should have_selector('title', text: full_title('About')) }
  end

  describe "People page" do
    before { visit people_path }
    
    it { should have_selector('title', text: full_title('People')) }
  end
  
  describe "Publications page" do
    before { visit publications_path }
    
    it { should have_selector('title', text: full_title('Publications')) }
  end

  describe "Links page" do
    before { visit links_path }
    
    it { should have_selector('title', text: full_title('Links')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "People"
    page.should have_selector 'title', text: full_title('People')
    click_link "Publications"
    page.should have_selector 'title', text: full_title('Publications')
    click_link "Links"
    page.should have_selector 'title', text: full_title('Links')
    click_link "ezra"
    page.should have_selector 'title', text: full_title('')
  end
  
end
