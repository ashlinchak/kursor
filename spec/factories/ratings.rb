# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    rateable_type "MyString"
    rateable_id 1
    votes_count 1
    total_value 1
    average_value 1.5
  end
end
