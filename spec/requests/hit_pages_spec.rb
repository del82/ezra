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

      describe "should display the target and hit number" do
        it { should have_selector('#hit-title', text: hit.target.phrase+' '+hit.id.to_s)}
      end

      describe "should display the transcript in a textarea" do
        it { should have_selector('#transcript', :content => hit.transcript)}
      end

      describe "should load the correct audio file" do
        it { should have_selector('#sm-container ul li a', :href => hit.audio_file)}
      end

      describe "commit button" do
        it "should start by saying 'No changes'" do
          page.should have_button("No changes")
          page.should_not have_button("Save changes")
        end

        describe "should change to 'Save changes'" do
          it "when transcript is changed" do
            fill_in "hit_transcript", with: "test notes go here"
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end

          it "when flag is changed"  do
            find('#flag-checkbox').click
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end
 
          it "when notes field is changed" do
            fill_in "hit_notes", with: "test notes go here"
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end

          it "when transcript boundary is changed" do
            fill_in "start-time-hours", with: 1
            page.should have_button("Save changes")
            page.should_not have_button("No changes")
          end
        end
      end
    end
  end
end
