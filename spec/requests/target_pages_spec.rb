require 'spec_helper'

describe "Target pages" do
  subject { page }

  context "while not signed-in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:target) { FactoryGirl.create(:target) }

    describe "visit targets_path" do
      before { visit targets_path }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit target_path" do
      before { visit target_path(target) }
      it { should have_selector('title', text: "Sign in") }
    end

    describe "visit new_target_path" do
      before { visit new_target_path }
      it { should have_selector('title', text: "Sign in") }
      end

    describe "visit edit_target_path" do
      before { visit edit_target_path(target) }
      it { should have_selector('title', text: "Sign in") }
    end

  end

# ----
  context "while signed-in as user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:target) { FactoryGirl.create(:target) }
    let(:hit_flag) { FactoryGirl.create(:hit, flagged: true, target: target) }
    let(:hit_no_flag) { FactoryGirl.create(:hit, flagged: false, target: target) }

    before do
      visit signin_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    describe "target index" do
      before { visit targets_path }

      describe "should allow access and have the right title" do
        it { should have_selector('title', text: 'Targets') }
      end

    end

    describe "individual target page" do
      before do
        hit_flag.target = target
        hit_no_flag.target = target
        visit target_path(target)
      end

      describe "should have the right title" do
        it { should have_selector('title', text: target.phrase) }
      end

      describe "should have the hits" do
        it { should have_link(hit_flag.id.to_s) }
      end

      describe "should filter on flagged parameter" do
        before do
          visit target_path(target, {flagged: "true" })
        end
        it { should have_link(hit_flag.id.to_s) }
        it { should_not have_link(hit_no_flag.id.to_s, href: hit_path(hit_no_flag)) }
      end

    end

    describe "create target page" do
      before { visit new_target_path }

      describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end

    describe "edit target page" do
      let(:target) { FactoryGirl.create(:target) }
      before { visit edit_target_path(target) }

      describe "should be redirected to user page" do
        it { should have_selector('title', text: user.username) }
      end
    end
  end

# ----
  context "while signed-in as admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:target) { FactoryGirl.create(:target) }


    before do
      visit signin_path
      fill_in "Password", with: admin.password
      fill_in "Username", with: admin.username
      click_button "Sign in"
    end

    describe "visiting target index" do
      before { visit targets_path }

      describe "should have the right title" do
        it { should have_selector('title', text: 'Targets') }
      end

      describe "should display the right statistics" do
        before do
          target.hits.create(FactoryGirl.attributes_for(:hit, confirmed: -1,
                                                              flagged: true))
          target.hits.create(FactoryGirl.attributes_for(:hit, confirmed: 0))
          target.hits.create(FactoryGirl.attributes_for(:hit, confirmed: 0,
                                                              flagged: true))
          target.hits.create(FactoryGirl.attributes_for(:hit, confirmed: 1))
          visit targets_path
        end

        it { should have_selector('a.confirmed',    content: "1") }
        it { should have_selector('a.unconfirmed',  content: "2") }
        it { should have_selector('a.not-present', content: "1") }
        it { should have_selector('a.flags',    content: "2") }

      end
    end

    describe "individual target page" do
      before { visit target_path(target) }

      describe "should have the right title" do
        it { should have_selector('title', text: target.phrase) }
      end
    end

    describe "create target page" do
      before { visit new_target_path }

      describe "should have the right title" do
        it { should have_selector('title', text: 'New target' ) }
      end
    end

    describe "edit target page" do
      before { visit edit_target_path(target) }
      describe "should have the right title" do
        it { should have_selector('title', text: 'Edit "' + target.phrase + '"') }
      end
    end

  end  # context: signed-in as admin
end
