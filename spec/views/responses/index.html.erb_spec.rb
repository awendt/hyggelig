require 'spec_helper'

describe "/responses/index.html.erb" do
  include ResponsesHelper

  before(:each) do
    assigns[:responses] = [
      stub_model(Response),
      stub_model(Response)
    ]
  end

  it "renders a list of responses" do
    render
  end
end
