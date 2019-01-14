require 'rails_helper'

RSpec.describe Product, type: :model do
  # Validation tests
  # ensure all columns are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:inventory_count) }
end
