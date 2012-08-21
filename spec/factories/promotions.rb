# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :promotion do
    start_date "2012-08-21 15:58:16"
    end_date "2012-08-21 15:58:16"
    promotinable nil
    is_featured false
    is_vip false
  end
end
