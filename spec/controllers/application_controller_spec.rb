require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController do

  describe "before filter to set the locale" do
    before do
      I18n.should_receive(:available_locales).and_return([:de, :en])
      controller.should_receive(:params).and_return(:locale => nil)
    end

    it "should always return TRUE" do
      request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "en-US"} )
      controller.should_receive(:request).any_number_of_times.and_return(request)
      controller.send(:set_locale).should be_true
    end

    it "should set the localization language to English if header asks for English contents" do
      request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "en-US"} )
      controller.should_receive(:request).any_number_of_times.and_return(request)
      I18n.should_receive(:locale=).with(:en)
      controller.send(:set_locale).should be_true
    end

    it "should set the localization language to German if header asks for German contents" do
      request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "de"} )
      controller.should_receive(:request).any_number_of_times.and_return(request)
      I18n.should_receive(:locale=).with(:de)
      controller.send(:set_locale).should be_true
    end

    it "should set the localization language to English as default" do
      request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "dv"} )
      controller.should_receive(:request).any_number_of_times.and_return(request)
      I18n.should_receive(:locale=).with(:en)
      controller.send(:set_locale).should be_true
    end
  end

  describe "default URL options" do
    it "returns the locale if given" do
      controller.should_receive(:params).and_return(:locale => :en)
      controller.send(:default_url_options).should == {:locale => :en}
    end

    it "returns an empty hash if no locale given" do
      controller.should_receive(:params).and_return({})
      controller.send(:default_url_options).should == {}
    end
  end

end