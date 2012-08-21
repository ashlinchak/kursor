require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :title => "MyString",
      :description => "MyText",
      :eventable_id => 1,
      :eventable_type => "MyString",
      :location_id => 1,
      :min_price => 1,
      :max_price => 1,
      :teacher => "MyString"
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path(@event), :method => "post" do
      assert_select "input#event_title", :name => "event[title]"
      assert_select "textarea#event_description", :name => "event[description]"
      assert_select "input#event_eventable_id", :name => "event[eventable_id]"
      assert_select "input#event_eventable_type", :name => "event[eventable_type]"
      assert_select "input#event_location_id", :name => "event[location_id]"
      assert_select "input#event_min_price", :name => "event[min_price]"
      assert_select "input#event_max_price", :name => "event[max_price]"
      assert_select "input#event_teacher", :name => "event[teacher]"
    end
  end
end
