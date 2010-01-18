require 'spec_helper'

describe "/replies/new.html.erb" do
  include RepliesHelper

  before(:each) do
    assigns[:reply] = stub_model(Reply,
      :new_record? => true
    )
  end

  it "renders new reply form" do
    render

    response.should have_tag("form[action=?][method=post]", replies_path) do
    end
  end
end
