require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do

  describe 'displaying a label with hint' do

    it "should call the label helper" do
      helper.should_receive(:label)
      helper.label_with_hint(:foo, :bar, :text, :hint)
    end

    it "should contain the hint within another element" do
      markup = helper.label_with_hint(:foo, :bar, 'text', 'hint')
      markup.should have_tag('span[class=hint]', :text => 'hint')
    end

  end

end