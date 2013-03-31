require 'spec_helper'

describe "statics/new" do
  before(:each) do
    assign(:static, stub_model(Static,
      :title => "MyString",
      :content => "MyText",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new static form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => statics_path, :method => "post" do
      assert_select "input#static_title", :name => "static[title]"
      assert_select "textarea#static_content", :name => "static[content]"
      assert_select "input#static_slug", :name => "static[slug]"
    end
  end
end
