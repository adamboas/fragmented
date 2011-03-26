require 'spec_helper'

describe FragmentHelper do
  let(:fragment) { stub_model(Fragment, :id => 11) }

  describe '#fragment_tag' do
    subject { helper.fragment_tag(fragment, '/') }
    it "should generate a div to surround the fragment contents" do
      subject.should have_selector('div.fragment')
    end

    it "should give the surrounding div the id of fragment_ with the id provided appended" do
      subject.should have_selector('div.fragment', :id => 'fragment_11')
    end

    it "should render the fragment contents into the read-area if provided with a fragment_id" do
      fragment.stub(:contents).and_return 'some contents'
      subject.should have_selector('div', :class => 'read-area', :content => 'some contents')
    end

    context "when in editable mode" do
      it "should give the surrounding div the class editable" do
        subject.should have_selector('div', :class => 'fragment editable')
      end

      it "should generate a text area for editing the fragment" do
        subject.should have_selector('textarea', :class => 'edit-area')
      end

      it "should generate a text area with an id based on the fragment_id for editing the fragment" do
        subject.should have_selector('textarea', :class => 'edit-area', :id => 'contents_11')
      end

      it "should generate a div to contain the fragment in read mode" do
        subject.should have_selector('div', :class => 'read-area')
      end

      it "should generate an edit link" do
        subject.should have_selector('a', :content => 'edit')
      end

      it "should generate an edit link with the class edit-link" do
        subject.should have_selector('a', :class => 'edit-link')
      end

      it "should generate a script block for initializing the javascript" do
        helper.should_receive(:script_block).with(fragment, '/').and_return('stuff')
        subject
      end
    end

    context " when in read-only mode" do
      subject { helper.fragment_tag(fragment, '/', false) }
      it "should generate a div to contain the fragment in read mode" do
        subject.should have_selector('div', :class => 'read-area')
      end

      it "should not generate tags for editing" do
        helper.should_not_receive(:edit_tags)
        subject
      end

      it "should not generate a text area for editing the fragment" do
        subject.should_not have_selector('textarea', :class => 'edit-area')
      end
    end
  end
end
