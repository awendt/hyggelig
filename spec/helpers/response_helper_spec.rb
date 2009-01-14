require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseHelper do

  describe "" do

    before do
      I18n.should_receive(:t).with(anything, :name => "").and_return("foo")
      I18n.should_receive(:t).with(anything, :name => "name").and_return("foo name")
    end

    describe "accepted_tag" do
      it "should surround everything but the name with a tag" do
        markup = helper.accepted_tag("name")
        markup.should have_tag("span[class=textonly]", :text => "foo")
        markup.should =~ /name/
      end
    end

    describe "declined_tag" do
      it "should surround everything but the name with a tag" do
        markup = helper.declined_tag("name")
        markup.should have_tag("span[class=textonly]", :text => "foo")
        markup.should =~ /name/
      end
    end
  end

end
