require 'spec_helper'

describe "/responses/edit.html.erb" do
  include ResponsesHelper

  before(:each) do
    assigns[:response] = @response = stub_model(Response,
      :new_record? => false
    )
  end

  it "renders the edit response form" do
    render

    response.should have_tag("form[action=#{response_path(@response)}][method=post]") do
    end
  end
end
