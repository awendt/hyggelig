require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do

  describe 'displaying a label with hint' do

    it "should call the label helper" do
      helper.should_receive(:label)
      helper.label_with_hint(:foo, :bar, 'text', 'hint')
    end

    it "should contain the hint within another element" do
      markup = helper.label_with_hint(:foo, :bar, 'text', 'hint')
      markup.should have_selector('span[class=hint]', :content => 'hint')
    end

  end

  describe 'piwik tracker code' do

    it 'renders the code in production' do
      helper.should_receive(:rails_env).and_return('production')
      helper.piwik_tracker_code.should have_selector('script')
    end

    it 'does not render the code in tests' do
      helper.should_receive(:rails_env).and_return('test')
      helper.piwik_tracker_code.should == ''
    end

    it 'does not render the code in development' do
      helper.should_receive(:rails_env).and_return('development')
      helper.piwik_tracker_code.should == ''
    end

  end
end