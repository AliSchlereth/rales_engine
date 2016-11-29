FactoryGirl.define do
  factory :item do
    name "MyText"
    description "MyText"
    merchant
    unit_price 1
  end
end
