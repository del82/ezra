require 'spec_helper'

describe Target do
  let(:user) { FactoryGirl.create(:user) }
  before { @target = user.targets.build(target_string: "target string") }
  
  subject { @target }

  it { should respond_to(:target_string) } 
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
    
  it { should be_valid }

  describe "when user_id is not present" do
    before { @target.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Target.new(user_id: user.id)
      end.to raise_error (ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "when user_id is not present" do
    before { @target.user_id = nil }
    it { should_not be_valid }
  end
end
