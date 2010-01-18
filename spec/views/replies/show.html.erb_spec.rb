require 'spec_helper'

describe "/replies/show.html.erb" do
  include RepliesHelper
  before(:each) do
    assigns[:reply] = @reply = stub_model(Reply)
  end

  it "renders attributes in <p>" do
    render
  end
end
