require 'csv'

namespace :load_test_data do
  desc "Import test data from csv"
  task products: :environment do
    counter = 0
    success_counter = 0
    CSV.foreach("db/testdata/products.csv") do |row|
      title, price, inventory_count = row
      product = Product.create(title: title, price: price, inventory_count, inventory_count)
      
      counter += 1
      success_counter += 1 if product.persisted?
    end
    
    puts "Imported #{success_counter} out of #{counter} products"
  end
end