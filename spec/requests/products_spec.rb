require 'rails_helper'

# This is essentially the test suite for products
RSpec.describe 'Store API', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:products) do
    Product.where( { title: "testprod1", price: 10.99, inventory_count: 0 } ).first_or_create
    Product.where( { title: "testprod2", price: 10.99, inventory_count: 100 } ).first_or_create
    create_list(:product, 9)
  end
  let(:product_id) { products.first.id }
  let(:test_id1) { Product.where( { title: "testprod1" } ).first.id }
  let(:test_id2) { Product.where( { title: "testprod2" } ).first.id }
  
  #authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /products
  describe 'GET /products' do
    # make HTTP get request before each example
    before { get '/products', headers: headers }

    it 'returns products' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  # Test suite for GET /products?onlyinstock=0
  describe 'GET /products?onlyinstock=0' do
    before { get "/products?onlyinstock=0", headers: headers }
    
    it 'returns products' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  # Test suite for GET /products?onlyinstock=1
  describe 'GET /products?onlyinstock=1' do
    before { get "/products?onlyinstock=1", headers: headers }
    
    it 'returns products' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
    
  # Test suite for GET /products/:id
  describe 'GET /products/:id' do
    before { get "/products/#{product_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(product_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end
  
  # Test suite for POST /products/purchase
  describe 'POST /products/purchase' do
    #test payloads
    let(:test1_purchase) { { id: test_id1.to_s}.to_json }
    let(:test2_purchase) { { id: test_id2.to_s }.to_json }
    let(:invalid_purchase) { { id: '9999' }.to_json }
    
    # Purchasing a product without stock
    context 'when the request is valid' do
      before { post "/products/purchase", params: test1_purchase, headers: headers }
      
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['inventory_count']).to eq(0)
      end
    end

    # Purchasing a product with stock
    context 'when the request is valid' do
      before { post "/products/purchase", params: test2_purchase, headers: headers }
      
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['inventory_count']).to eq(99)
      end
    end
    
    context 'when the record does not exist' do
      before { post "/products/purchase", params: invalid_purchase, headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end

  end 
  
end