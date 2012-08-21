require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :title => "Title",
      :description => "MyText",
      :eventable_id => 1,
      :eventable_type => "Eventable Type",
      :location_id => 2,
      :min_price => 3,
      :max_price => 4,
      :teacher => "Teacher"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Eventable Type/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Teacher/)
  end
end
