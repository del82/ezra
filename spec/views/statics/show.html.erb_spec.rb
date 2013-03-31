require 'spec_helper'

describe "statics/show" do
  before(:each) do
    @static = assign(:static, stub_model(Static,
      :title => "Title",
      :content => "MyText",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Slug/)
  end
end
