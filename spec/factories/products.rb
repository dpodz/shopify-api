FactoryBoy.define do
  factory :todo do
    title { Faker::Food.dish }
    price { Faker::Number.decimal(2) }
    inventory_count { Faker::Number.number(2) }
  end
end