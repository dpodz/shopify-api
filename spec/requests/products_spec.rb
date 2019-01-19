require 'rails_helper'

# This is essentially the test suite for products
RSpec.describe 'Store API', type: :request do
  # initialize test data 
  let!(:products) do
    Product.where( { title: "testprod1", price: 10.99, inventory_count: 0 } ).first_or_create
    Product.where( { title: "testprod2", price: 10.99, inventory_count: 100 } ).first_or_create
    create_list(:product, 9)
  end
  let(:product_id) { products.first.id }
  let(:test_id) { Product.where( { title: "testprod2" } ).first.id }

  # Test suite for GET /products
  describe 'GET /products' do
    # make HTTP get request before each example
    before { get '/products' }

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
    before { get "/products?onlyinstock=0" }
    
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
    before { get "/products?onlyinstock=1" }
    
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
    before { get "/products/#{product_id}" }

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
  
  # Test suite for POST /products/:id/purchase
  describe 'POST /products/:id/purchase' do
    #valid payload
    let(:valid_purchase) { { } }
    
    context 'when the request is valid' do
      before { post "/products/#{test_id}/purchase", params: valid_purchase }
      
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['inventory_count']).to eq(99)
      end
      
    end
  end 

=begin
  # Test suite for POST /products
  describe 'POST /products' do
    # valid payload
    let(:valid_attributes) { { title: 'Back Scratcher', price: '10.99', inventory_count: '69' } }

    context 'when the request is valid' do
      before { post '/products', params: valid_attributes }

      it 'creates a product' do
        expect(json['title']).to eq('Back Scratcher')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/products', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Price can't be blank/)
      end
    end
  end

  # Test suite for PUT /products/:id
  describe 'PUT /products/:id' do
    let(:valid_attributes) { { title: 'Plunger' } }

    context 'when the record exists' do
      before { put "/products/#{product_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /products/:id
  describe 'DELETE /products/:id' do
    before { delete "/products/#{product_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
=end
end