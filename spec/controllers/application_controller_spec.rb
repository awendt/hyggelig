require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController, "before filter to set the locale" do

  before do
    controller.should_receive(:available_locales).and_return([:de, :en])
  end

  it "should always return TRUE" do
    request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "en-US"} )
    controller.should_receive(:request).and_return(request)
    controller.send(:set_locale).should be_true
  end

  it "should set the localization language to English if header asks for English contents" do
    request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "en-US"} )
    controller.should_receive(:request).and_return(request)
    I18n.should_receive(:locale=).with(:en)
    controller.send(:set_locale).should be_true
  end

  it "should set the localization language to German if header asks for German contents" do
    request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "de"} )
    controller.should_receive(:request).and_return(request)
    I18n.should_receive(:locale=).with(:de)
    controller.send(:set_locale).should be_true
  end

  it "should set the localization language to English as default" do
    request = mock('request', :env => { "HTTP_ACCEPT_LANGUAGE" => "dv"} )
    controller.should_receive(:request).and_return(request)
    I18n.should_receive(:locale=).with(:en)
    controller.send(:set_locale).should be_true
  end

end