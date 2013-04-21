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

  context "while signed in as admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    before do
      visit signin_path
      fill_in "Password", with: admin.password
      fill_in "Username", with: admin.username
      click_button "Sign in"
    end

    # why is it not switching to be an admin?!
    pending "edit hit page" do
      before { visit edit_hit_path(hit) }

      describe "should see the download file button" do
        it { should have_selector('#download', text: 'Download') }
      end

      pending "should be able to download the file" do
        #I don't know what to do here?
      end
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

      describe "should display the target and hit number" do
        it { should have_selector('#hit-title', text: hit.target.phrase+' '+hit.id.to_s)}
      end

      describe "should display the transcript in a textarea" do
        it { should have_selector('#transcript', :content => hit.transcript)}
      end

      describe "should load the correct audio file" do
        it { should have_selector('#sm-container ul li a', :href => hit.audio_file)}
      end

      describe "should display help interface" do
        it "on click" do
          click_link 'help-link'
          page.should have_selector('#help', visible: true)
        end

      end

      describe "commit button" do
        it "should start by saying 'No changes'" do
          page.should have_button("No changes")
          page.should_not have_button("Save changes")
        end

        # Capybara does not register a change event
        # while using fill_in, so it doesn't look
        # like these tests will ever actually pass.
        # I tried switching to Capybara-webkit, but
        # it's keeps throwing errors.

        # Capybara.javascript_driver = :webkit
        pending "should change to 'Save changes'", :js => true do
          it "when transcript is changed" do
            fill_in "hit-transcript", with: "test notes go here"
            find('#hit-transcript').trigger("change")
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end

          it "when flag is changed"  do
            find('#flag-checkbox').click
            find('#flag-checkbox').trigger("change")
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end

          it "when notes field is changed" do
            fill_in "hit-notes", with: "test notes go here"
            find('#hit-notes').trigger("change")
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end

          it "when transcript boundary is changed" do
            fill_in "start-time-hours", with: 1
            find('#start-time-hours').trigger("change")
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end
        end
        # Capybara.use_default_driver

        describe "should not be able to download file" do
          it { should_not have_selector('#download', text: 'Download')}
        end
      end
    end
  end
end
