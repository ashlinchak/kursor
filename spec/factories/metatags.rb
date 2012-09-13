# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :metatag do
    title "MyString"
    description "MyText"
    keywodrs "MyText"
    additional "MyText"
    split_keywords false
    metatagable_id 1
    metatagable_type "MyString"
  end
end
