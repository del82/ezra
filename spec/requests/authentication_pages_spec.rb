require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('title', text: full_title("Sign in")) }
  end
end
