require 'spec_helper'

describe "/replies/index.html.erb" do
  include RepliesHelper

  before(:each) do
    assigns[:replies] = [
      stub_model(Reply),
      stub_model(Reply)
    ]
  end

  it "renders a list of replies" do
    render
  end
end
