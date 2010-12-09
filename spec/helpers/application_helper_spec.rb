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

    it 'renders html_safe text' do
      helper.should_receive(:rails_env).and_return('production')
      helper.piwik_tracker_code.should be_html_safe
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

  describe "links to other locales" do
    it 'renders links' do
      links = helper.links_for_other_locales
      links.should have_selector('a[href]', :content => 'Deutsch')
      links.should have_selector('a[href]', :content => 'Italiano')
    end

    it 'does not put locale into URL for default locale' do
      I18n.default_locale = :it
      links = helper.links_for_other_locales
      links.should have_selector("a[href='http://test.host/de']", :content => 'Deutsch')
      links.should have_selector("a[href='http://test.host/']", :content => 'Italiano')
    end
  end

end