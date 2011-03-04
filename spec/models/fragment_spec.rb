require 'spec_helper'

describe Fragment do
  it "should be invalid without contents" do
    Fragment.new.should have(1).error_on(:contents)
  end
end
