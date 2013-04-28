require 'spec_helper'

describe "User pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  context "while not signed-in" do
    describe "visit users_path" do
      before { visit users_path }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit user_path" do
      before { visit user_path(user) }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit new_user_path" do
      before { visit new_user_path }
      it { should have_selector('title', text: "Sign in") }
      end

    describe "visit edit_user_path" do
      before { visit edit_user_path(user) }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit manage_user_path" do
      before { visit manage_path(user) }
      it { should have_selector('title', text: "Sign in") }
    end
  end

  context "while signed-in as user" do
    before do
      visit new_user_session_path
      fill_in "Password", with: user.password
      fill_in "Login", with: user.username
      click_button "Sign in"
    end

    describe "user index" do
      before { visit users_path }

     describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end

    describe "individual user page" do
      before { visit user_path(user) }

      describe "should have the right title" do
        it { should have_selector('title', text: user.username) }
      end
    end

    describe "create user page" do
      before { visit new_user_path }

      describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end

    describe "edit user page" do
      before { visit edit_user_path(user) }

      describe "should have the right title" do
        it { should have_selector('title', text: 'Update '+user.username) }
      end
    end

    describe "manage user page" do
      before { visit manage_path(user) }

      pending "should be redirected anywhere but manage user" do
        it { response.should_not have_selector('title', text: 'Manage "'+user.username+'"') }
      end
    end
  end

  context "while signed-in as admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    before do
      visit new_user_session_path
      fill_in "Password", with: admin.password
      fill_in "Login", with: admin.username
      click_button "Sign in"
    end

    describe "user index" do
      before { visit users_path }

      describe "should have the right title" do
        it { should have_selector('title', text: 'Users' ) }
      end
    end

    describe "individual user page" do
      before { visit user_path(admin) }

      describe "should have the right title" do
        it { should have_selector('title', text: admin.username) }
      end
    end

    describe "create user page" do
      before { visit new_user_path }

      describe "should have the right title" do
        it { should have_selector('title', text: 'New user' ) }
      end
    end

    describe "edit user page" do

      describe "for admin user" do
        before { visit edit_user_path(admin) }
        describe "should have the right title" do
          it { should have_selector('title', text: 'Update '+admin.username) }
        end
      end

      describe "for other user" do
        before { visit edit_user_path(user) }
        let(:user) { FactoryGirl.create(:user) }
        describe "should have the right title" do
          it { should have_selector('title', text: 'Update '+user.username) }
        end
      end
    end

    pending "manage user page" do

      describe "for the admin" do
        before { visit manage_path(admin) }
        describe "should have the right title" do
          it { response.should have_selector('title', text: 'Manage "'+admin.username+'"') }
        end
      end

      describe "for another user" do
        before { visit manage_path(user) }
        let(:user) { FactoryGirl.create(:user) }
        describe "should have the right title" do
          it { response.should have_selector('title', text: 'Manage "'+user.username+'"') }
        end
      end
    end
  end
end
  # describe "create user" do
  #   before { visit new_user_path }

  #   let(:submit) { "Create user" }

    #   describe "with invalid information" do
    #     it "should not create a user" do
    #       expect { click_button submit }.not_to change(User, :count)
    #     end

    #     describe "after submission" do
    #       before { click_button submit }

    #       it { should have_selector('title', text: 'New user') }
    #       it { should have_content('error') }
    #     end
    #   end

    #   describe "with valid information" do
    #     before do
    #       fill_in "Full Name",      with: "Example User"
    #       fill_in "Login",       with: "exampleuser"
    #       fill_in "Email",          with: "user@example.com"
    #       fill_in "Password",       with: "foobar"
    #       fill_in "Confirmation",   with: "foobar"
    #     end

    #     it "should create a user" do
    #       expect { click_button submit }.to change(User, :count).by(1)
    #     end

    #     describe "after saving the user" do
    #       before { click_button submit }
    #       let(:user) { User.find_by_username('exampleuser') }
    #       it { should have_selector('div.alert.alert-success', text:'success') }
    #     end
    #   end
    # end
