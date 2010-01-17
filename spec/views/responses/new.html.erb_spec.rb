require 'spec_helper'

describe "/responses/new.html.erb" do
  include ResponsesHelper

  before(:each) do
    assigns[:response] = stub_model(Response,
      :new_record? => true
    )
  end

  it "renders new response form" do
    render

    response.should have_tag("form[action=?][method=post]", responses_path) do
    end
  end
end
