require 'spec_helper'

describe Fragment do
  it "should be invalid without contents" do
    Fragment.new.should have(1).error_on(:contents)
  end

  describe "#createPlaceholder!" do
    subject { Fragment.create_placeholder!() }
    let(:created_fragment) { stub_model(Fragment)}

    it "should call create! with placeholder text" do
      Fragment.should_receive(:create!).with(:contents => '<h1>Fragment</h1>\n<p>edit this to add your content</p>')
      subject
    end

    it "should return the created fragment" do
      Fragment.stub(:create!).and_return(created_fragment)
      subject.should == created_fragment
    end
  end
end
