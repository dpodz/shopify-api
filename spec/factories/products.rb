FactoryBot.define do
  factory :product do
    title { Faker::Food.dish }
    price { Faker::Number.decimal(2) }
    inventory_count { Faker::Number.between(1,100) }
  end
end