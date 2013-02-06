require 'spec_helper'

describe "Static pages" do

  subject { page }


  shared_examples_for "all static pages" do
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    let(:page_title) { '' }

    before { visit root_path }
    
    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
  end


  describe "About page" do
    let(:page_title) { 'About' }
    before { visit about_path }
    
    it_should_behave_like "all static pages"
  end

  describe "People page" do
    let(:page_title) { 'People' }
    before { visit people_path }
    
    it_should_behave_like "all static pages"
  end
  
  describe "Publications page" do
    let(:page_title) { 'Publications' }
    before { visit publications_path }
    
    it_should_behave_like "all static pages"
  end

  describe "Links page" do
    let(:page_title) { 'Links' }
    before { visit links_path }

    it_should_behave_like "all static pages"
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
