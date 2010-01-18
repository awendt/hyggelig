require 'spec_helper'

describe "/events/show.html.erb" do
  include EventsHelper
  before(:each) do
    assigns[:event] = @event = stub_model(Event,
      :name => "value for name",
      :date => "value for date",
      :location => "value for location"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ date/)
    response.should have_text(/value\ for\ location/)
  end
end
