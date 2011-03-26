require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    before do
      Fragment.stub(:find).and_return(stub_model(Fragment))
    end
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
