require 'spec_helper'

describe Feature do
  let(:user) { FactoryGirl.create(:user) }
  before { @feature = user.features.build(name: "test feature",
                                   instructions: "test feature instructions") }
  
  subject { @feature }

  it { should respond_to(:name) }
  it { should respond_to(:instructions) }
  it { should respond_to(:user_id) }
  its(:user) { should == user }
  
  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Feature.new(user_id: user.id)
      end.to raise_error (ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @feature.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank name" do
    before { @feature.name = " " }
    it { should_not be_valid }
    end
  
  describe "with name that is too short" do
    before { @feature.name = 'a'*3 }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @feature.name = "z" * 26 }
    it { should_not be_valid }
  end

  describe "with blank instructions" do
    before { @feature.instructions = " " }
    it { should_not be_valid }
  end

end
