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
  
end
