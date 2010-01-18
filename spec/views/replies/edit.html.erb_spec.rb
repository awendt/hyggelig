require 'spec_helper'

describe "/replies/edit.html.erb" do
  include RepliesHelper

  before(:each) do
    assigns[:reply] = @reply = stub_model(Reply,
      :new_record? => false
    )
  end

  it "renders the edit reply form" do
    render

    response.should have_tag("form[action=#{reply_path(@reply)}][method=post]") do
    end
  end
end
