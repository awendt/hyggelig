require 'spec_helper'

describe "/responses/show.html.erb" do
  include ResponsesHelper
  before(:each) do
    assigns[:response] = @response = stub_model(Response)
  end

  it "renders attributes in <p>" do
    render
  end
end
