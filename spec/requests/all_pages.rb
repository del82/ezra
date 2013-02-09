
shared_examples "all pages" do
  describe "should have exactly one instance of 'ezra' in title" do
    it { should have_selector("title", text: 'ezra' ) }
    it { should_not have_selector("title", text: 'ezra | ezra' ) }
  end
end
