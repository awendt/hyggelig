require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseHelper do

  before do
    I18n.should_receive(:t).with(anything, :name => "").and_return("foo")
    I18n.should_receive(:t).with(anything, :name => "John Doe").and_return("foo John Doe")
  end

  describe "surround_all_but_name" do

    it "should surround everything but the name with a tag" do
      markup = helper.surround_all_but_name("John Doe", :bar)
      markup.should have_tag("span[class=textonly]", :text => "foo")
      markup.should =~ /John Doe/
    end

  end

  describe "list_item_for" do

    it "should return a list item" do
      markup = helper.list_item_for(mock_model(Response, :attending? => true, :name => "John Doe"))
      markup.should have_tag("li", :text => "foo John Doe")
    end

  end

end
