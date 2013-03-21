require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
  end


  describe "About page" do
    before { visit about_path }
  end

  describe "People page" do
    before { visit people_path }
  end

  describe "Publications page" do
    before { visit publications_path }
  end

  describe "Links page" do
    before { visit links_path }
  end

  it "should have the right links on the layout" do
    visit root_path
    page.should have_selector 'title', text: 'Home'
    click_link "About"
    page.should have_selector 'title', text: 'About'
    click_link "People"
    page.should have_selector 'title', text: 'People'
    click_link "Publications"
    page.should have_selector 'title', text: 'Publications'
    click_link "Links"
    page.should have_selector 'title', text: 'Links'
    click_link "ezra"
    page.should have_selector 'title', text: ''
  end

end
