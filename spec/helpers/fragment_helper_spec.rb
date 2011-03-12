require 'spec_helper'

describe FragmentHelper do
  before do
    @fragment = stub_model(Fragment,:id => 11)
  end
  describe '#fragment_tag' do

    it "should generate a div to surround the fragment contents" do
      helper.fragment_tag(@fragment, '/').should have_selector('div.fragment')
    end

    it "should give the surrounding div the id of fragment_ with the id provided appended" do
      helper.fragment_tag(@fragment, '/').should have_selector('div.fragment', :id => 'fragment_11')
    end

    it "should render the fragment contents into the read-area if provided with a fragment_id" do
      @fragment.stub(:contents).and_return 'some contents'
      helper.fragment_tag(@fragment, '/').should have_selector('div', :class => 'read-area', :content => 'some contents')
    end

    context "when in editable mode" do
      it "should give the surrounding div the class editable" do
        helper.fragment_tag(@fragment, '/').should have_selector('div', :class => 'fragment editable')
      end

      it "should generate a text area for editing the fragment" do
        helper.fragment_tag(@fragment, '/').should have_selector('textarea', :class => 'edit-area')
      end

      it "should generate a text area with an id based on the fragment_id for editing the fragment" do
        helper.fragment_tag(@fragment, '/').should have_selector('textarea', :class => 'edit-area', :id => 'contents_11')
      end

      it "should generate a div to contain the fragment in read mode" do
        helper.fragment_tag(@fragment, '/').should have_selector('div', :class => 'read-area')
      end

      it "should contain read mode controls" do
        helper.should_receive(:read_controls)
        helper.fragment_tag(@fragment, '/')
      end

      it "should contain the edit mode controls" do
        helper.should_receive(:edit_controls)
        helper.fragment_tag(@fragment, '/')
      end

      it "should generate a script block for initializing the javascript" do
        helper.should_receive(:script_block).with(@fragment, '/')
        helper.fragment_tag(@fragment, '/')
      end
    end

    context " when in read-only mode" do
      it "should generate a div to contain the fragment in read mode" do
        helper.fragment_tag(@fragment, '/', false).should have_selector('div', :class => 'read-area')
      end

      it "should not contain edit or read controls" do
        helper.should_not_receive(:edit_controls)
        helper.should_not_receive(:read_controls)
        helper.fragment_tag(@fragment, '/', false)
      end

      it "should not generate a text area for editing the fragment" do
        helper.fragment_tag(@fragment, '/', false).should_not have_selector('textarea', :class => 'edit-area')
      end
    end
  end

  describe "#read_controls" do
    it "should generate a div to contain the controls" do
      helper.read_controls(@fragment).should have_selector('div', :class => 'read-controls')
    end

    it "should generate an edit link" do
      helper.read_controls(@fragment).should have_selector('a', :content => 'edit')
    end

    it "should generate an edit link with the class edit-link" do
      helper.read_controls(@fragment).should have_selector('a', :class => 'edit-link')
    end
  end

  describe "#edit_controls" do
    it "should generate a div to contain the controls" do
      helper.edit_controls().should have_selector('div', :class => 'edit-controls')
    end

    it "should generate a cancel link" do
      helper.edit_controls().should have_selector('a', :content => 'cancel')
    end

    it "should generate a cancel link with the class cancel-link" do
      helper.edit_controls().should have_selector('a', :class => 'cancel-link')
    end

    it "should generate a save button" do
      helper.edit_controls().should have_selector('button', :content => 'save')
    end

    it "should give the save button the class fragment-save" do
      helper.edit_controls().should have_selector('button', :class => 'fragment-save')
    end
  end
end
