require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "create user page" do
    before { visit new_user_path }

    it { should have_selector('title', text: full_title('New user')) }
  end

end
