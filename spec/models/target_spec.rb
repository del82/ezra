# == Schema Information
#
# Table name: targets
#
#  id         :integer          not null, primary key
#  phrase     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Target do
  let(:user) { FactoryGirl.create(:user) }
  before { @target = user.targets.build(phrase: "target string") }
  
  subject { @target }

  it { should respond_to(:phrase) } 
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should respond_to(:features) }
    
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

  describe "with blank phrase" do
    before { @target.phrase = " " }
    it { should_not be_valid }
  end

  describe "with phrase that is too long" do
    before { @target.phrase = "a" * 31 }
    it { should_not be_valid }
  end

end
