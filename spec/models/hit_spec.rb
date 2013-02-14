require 'spec_helper'

describe Hit do

  let(:target) { FactoryGirl.create(:target) }
  before { @hit = target.hits.build(location: 30.6,
                                    confirmed: 0,
                                    flagged: false,
                                    audio_file: "path/to/audio.mp3") }
  
  subject { @hit }

  it { should respond_to(:location) }
  it { should respond_to(:confirmed) }
  it { should respond_to(:flagged) }
  it { should respond_to(:audio_file) }
  it { should respond_to(:target_id) }
 
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
  
    
end
