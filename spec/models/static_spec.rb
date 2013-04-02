require 'spec_helper'

describe Static do

  before do
    @static = Static.new(title: 'Test static page',
                         short_title: 'Test static',
                         content: '# header 1\n\ntest content',
                         slug: 'test_static')
  end

  subject { @static }

  it { should respond_to(:title) }
  it { should respond_to(:short_title) }
  it { should respond_to(:content) }
  it { should respond_to(:slug) }

  it { should be_valid }

  describe "when title is not present" do
    before { @static.title = " " }
    it { should_not be_valid }
  end

  describe "when short title is not present" do
    before { @static.short_title = " " }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { @static.slug = " " }
    it { should_not be_valid }
  end

  describe "when slug is not present" do
    before { @static.slug = " " }
    it { should_not be_valid }
  end

end
