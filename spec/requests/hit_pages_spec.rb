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

    describe "visit hit_path" do
      before { visit hit_path(hit) }
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
      visit new_user_session_path
      fill_in "Password", with: admin.password
      fill_in "Login", with: admin.username
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
      visit new_user_session_path
      fill_in "Password", with: user.password
      fill_in "Login", with: user.username
      click_button "Sign in"
    end

    describe "hits index" do
      before { visit hits_path }

     describe "should have the right title" do
        it { should have_selector('title', text: 'Hits') }
      end

      describe "should paginate" do
        before do
          31.times do FactoryGirl.create(:hit) end
          visit hits_path
        end
        it { should have_selector('div.pagination') }
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
        it "should start by having five buttons" do
          page.should have_button("Save")
          page.should have_button("Previous")
          page.should have_button("Next")
          page.should have_button("Next Unconfirmed")
          page.should have_button("Cancel")
        end

      describe "Save button" do
        before do
          click_button "Save"
        end
        it "should refresh same hit when clicked" do
          page.should have_selector('title', text: 'Edit hit '+hit.id.to_s)
        end
      end

      pending "Save and Next button" do
        let(:target)   { FactoryGirl.create(:target )}
        let(:hit) { FactoryGirl.create(:hit, confirmed: 1, target: target, id: 1) }
        let(:hit2) { FactoryGirl.create(:hit, confirmed: 0, target: target, id: 2) }
        before do
          click_button "Save and Next"
        end
        it "should refresh to next hit when clicked" do
          page.should have_selector('title', text: 'Edit hit '+hit2.id.to_s)
        end
      end

      describe "Cancel button" do
        before do
          fill_in "hit_notes", with: "this shouldn't be saved"
          click_button "Cancel"
        end
        it "should refresh same hit without saving" do
          page.should have_selector('title', text: 'Edit hit '+hit.id.to_s)
          page.should_not have_selector('hit_notes', text: "this shouldn't be saved")
        end
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

    describe "doesn't crash when features are added" do
      # test for 500 bug when attempting to edit a hit which had features
      #  valued, and then had new features added to its target
      let(:feature1) { FactoryGirl.create(:feature, id: 100) }
      let(:feature2) { FactoryGirl.create(:multi_feature, id: 101) }
      let(:target)   { FactoryGirl.create(:target, features: [feature1]) }
      let(:hit) { FactoryGirl.create(:hit, target: target) }
      it "should not return a 500" do
        hit.feat_vals[feature1.id] = true
        hit.save!
        visit edit_hit_path(hit)

        page.should have_selector("title", text: "Edit hit #{hit.id}")
        target.features.push(feature2)
        target.save!
        hit.reload
        visit edit_hit_path(hit)
        page.should have_selector("title", text: "Edit hit #{hit.id}")

      end
    end
  end
end
