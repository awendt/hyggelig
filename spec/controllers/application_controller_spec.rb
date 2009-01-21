require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController, "before filter to set the locale" do

  before do
    controller.should_receive(:available_locales).and_return([:de, :en])
  end

  it "should set the locale to the language requested by the user" do
    controller.should_receive(:prefered_langs).and_return([:de])
    I18n.should_receive(:locale=).with(:de)
    controller.send(:set_locale).should be_true
  end

  it "should set the localization language to English as default" do
    controller.should_receive(:prefered_langs).and_return([:es])
    I18n.should_receive(:locale=).with(:en)
    controller.send(:set_locale).should be_true
  end

  it "should set the localization language to the first requested by the user" do
    controller.should_receive(:prefered_langs).and_return([:en, :de])
    I18n.should_receive(:locale=).with(:en)
    controller.send(:set_locale).should be_true
  end

end

describe ApplicationController, "prefered_langs" do

  it "should value subdomain requests higher than header" do
    controller.should_receive(:request).and_return(mock('request', :env => {'HTTP_ACCEPT_LANGUAGE' => 'de-de'}))
    controller.stub!(:current_subdomain).and_return("it")
    controller.send(:prefered_langs).should == [:it, :de]
  end

end

describe ApplicationController, 'parsing the HTTP_ACCEPT_LANGUAGE header' do

  before do
    @request = mock('request')
    controller.stub!(:request).and_return(@request)
  end

  describe 'with client_accepted_languages' do

    it 'should pass the header on to the parsing function' do
      @request.stub!(:env).and_return({'HTTP_ACCEPT_LANGUAGE' => 'foo'})
      controller.should_receive(:parse_http_accept_language_header).with('foo').and_return('bar')
      controller.send(:client_accepted_languages).should == 'bar'
    end

  end

  describe 'with parse_http_accept_language_header' do

    it "should return the empty array if no HTTP_ACCEPT_LANGUAGE is nil" do
      controller.send(:parse_http_accept_language_header, nil).should == []
    end

    it "should return the empty array if no HTTP_ACCEPT_LANGUAGE is empty string" do
      controller.send(:parse_http_accept_language_header, '').should == []
    end

    it "should be able to handle simple identifier" do
      controller.send(:parse_http_accept_language_header, 'de').should == [:de]
    end

    it "should be able to handle complex identifier" do
      controller.send(:parse_http_accept_language_header, 'de-de').should == [:de]
    end

    it "should be able to handle complex identifier with quality values" do
      controller.send(:parse_http_accept_language_header, 'de-de,de;q=0.8,en-us;q=0.5,en;q=0.3').should == [:de, :en]
    end

  end

end

describe ApplicationController, 'determining requested locale in subdomain' do

  it 'should return the subdomain as a symbol within an array' do
    controller.should_receive(:current_subdomain).and_return('de')
    controller.send(:locale_in_subdomain).should == [:de]
  end

  it 'should return an empty array if subdomain is nil' do
    controller.should_receive(:current_subdomain).and_return(nil)
    controller.send(:locale_in_subdomain).should == []
  end

end

describe ApplicationController, "redirecting to no subdomain" do

  it "should work if requested subdomain and HTTP_ACCEPT_LANGUAGE match" do
    controller.should_receive(:client_accepted_languages).and_return([:de])
    controller.should_receive(:locale_in_subdomain).and_return([:de])
    controller.should_receive(:redirect_to).with(:subdomain => false)
    controller.send(:drop_subdomain_if_duplicates_accept_language_header).should == false
  end

  it "should not work if requested subdomain and HTTP_ACCEPT_LANGUAGE differ" do
    controller.should_receive(:client_accepted_languages).and_return([:en])
    controller.should_receive(:locale_in_subdomain).and_return([:de])
    controller.should_not_receive(:redirect_to)
    controller.send(:drop_subdomain_if_duplicates_accept_language_header).should == true
  end

end