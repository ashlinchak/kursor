# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyText"
    eventable_id 1
    eventable_type "MyString"
    location_id 1
    start_datetime "2012-08-21 14:41:11"
    end_datetime "2012-08-21 14:41:11"
    min_price 1
    max_price 1
    teacher "MyString"
  end
end
