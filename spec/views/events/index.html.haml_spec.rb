require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :title => "Title",
        :description => "MyText",
        :eventable_id => 1,
        :eventable_type => "Eventable Type",
        :location_id => 2,
        :min_price => 3,
        :max_price => 4,
        :teacher => "Teacher"
      ),
      stub_model(Event,
        :title => "Title",
        :description => "MyText",
        :eventable_id => 1,
        :eventable_type => "Eventable Type",
        :location_id => 2,
        :min_price => 3,
        :max_price => 4,
        :teacher => "Teacher"
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Eventable Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Teacher".to_s, :count => 2
  end
end
