require 'spec_helper'

describe FragmentsController do
  let(:fragment) { stub_model(Fragment, :save => true)}

  describe "GET 'show" do
    subject{get :show, :id => '11'}
    before do
      Fragment.stub(:find).and_return(fragment)
    end

    it "should retrieve the fragment based on the id in the url" do
      Fragment.should_receive(:find).with('11')
      subject
    end
  end

  describe "PUT update" do
    subject {put :update, :id => '22', :fragment => {:contents => 'new contents'} }
    before do
      Fragment.stub(:find).and_return(fragment)
    end

    it "should retrieve the fragment based on the id in the url" do
      Fragment.should_receive(:find).with('22')
      subject
    end

    it "should update the fragments parameters with the contents provided" do
      fragment.should_receive(:update_attributes).with('contents' => 'new contents').and_return(true)
      subject
    end

    it "should respond with 400 if the create is unsuccessful" do
      fragment.stub(:update_attributes).and_return(false)
      subject
      response.code.should == '400'
    end
  end

  describe "DELETE destroy" do
    subject { delete :destroy, :id => '33'}
    before do
      Fragment.stub(:find).and_return(fragment)
    end

    it "should retrieve the fragment with the id in the url" do
      Fragment.should_receive(:delete).with('33')
      subject
    end
  end

  describe "POST create" do
    subject {post :create, :fragment => {:contents => 'contents'} }

    it "should create a new fragment with the parameters provided" do
      Fragment.should_receive(:create!).with('contents' => 'contents')
      subject
    end

    it "should respond with 400 if the create is unsuccessful" do
      Fragment.stub(:create!).and_raise('Hell')
      subject
      response.code.should == '400'
    end
  end
end