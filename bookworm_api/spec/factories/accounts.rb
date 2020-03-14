FactoryBot.define do
  factory :account do
    number { Time.now.to_i.to_s }
    initial_balance { Faker::Commerce.price }
    holder_name { Faker::Name.name }
  end
end
