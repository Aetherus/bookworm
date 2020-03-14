FactoryBot.define do
  factory :book do
    isbn { Faker::Code.isbn }
    title { Faker::Book.title }
    author { Faker::Name.name }
    published_on { Faker::Date.between(from: 50.years.ago, to: Date.today) }
    quantity { rand(10) }
    fee { Faker::Commerce.price }
  end
end
