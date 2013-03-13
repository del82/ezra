# == Schema Information
#
# Table name: hits
#
#  id              :integer          not null, primary key
#  location        :float
#  confirmed       :integer
#  flagged         :boolean
#  audio_file      :string(255)
#  target_id       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  transcript      :text
#  feat_vals       :text
#  window_start    :float
#  window_duration :float
#

require 'spec_helper'

describe Hit do

  let(:target) { FactoryGirl.create(:target) }
  before { 
    @hit = target.hits.build(location: 30.6, confirmed: 0, flagged: false,
                                    audio_file: "path/to/audio.mp3")
  }
  
  subject { @hit }

  it { should respond_to(:location) }
  it { should respond_to(:confirmed) }
  it { should respond_to(:flagged) }
  it { should respond_to(:audio_file) }
  it { should respond_to(:target_id) }
  it { should respond_to(:transcript) }
  it { should respond_to(:feat_vals) }
  it { should respond_to(:features) }
  it { should respond_to(:window_start) }
  it { should respond_to(:window_duration) }
 
  it { should be_valid }

  describe "location" do
    describe "must be present" do
      before { @hit.location = nil }
      it { should_not be_valid }
      end
    describe "must be postive" do
      before { @hit.location = -823.23 }
      it { should_not be_valid }
    end
  end

  describe "confirmed" do
    describe "must be present" do
      before { @hit.confirmed = nil }
      it { should_not be_valid }
    end
    describe "must be an integer" do
      before { @hit.confirmed = 4.3 }
      it { should_not be_valid }
    end
    describe "must be at most 1" do
      before { @hit.confirmed = 2 }
      it { should_not be_valid }
    end      
    describe "must be at least -2" do
      before { @hit.confirmed = -3 }
      it { should_not be_valid }
    end
  end

  describe "audio-file" do
    describe "must be present" do
      before { @hit.audio_file = nil }
      it { should_not be_valid }
    end
  end
  
  describe "relation to feature through target should work" do
  let(:feature) { FactoryGirl.create(:feature) }
    before{ target.features.concat(feature) }
    its(:features) { should eq([feature]) }
  end
    
end
