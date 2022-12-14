require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'if all fields not nil for product, it will save succefully' do
      category = Category.create(name: 'Apparel')
      @product = category.products.new
      @product.name = "name"
      @product.price = 100
      @product.quantity = 10
      expect(@product.save).to eql(true)
    end

    it 'fails with no name' do
      category = Category.create(name: 'Apparel')
      product = category.products.new
      product.update(price_cents: 100, quantity: 10, id: 1, description: "hello", image: "www.no.go")
      #product = Product.create(price_cents: 100, quantity: 10, id: 1, description: "hello", image: "www.no.go")
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'fails with no price' do
      product = Product.create(quantity: 10, id: 1, description: "hello", image: "www.no.go")
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'fails with no price' do
      product = Product.create(quantity: 10, id: 1, description: "hello", image: "www.no.go")
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
  
    it 'fails with no quantity' do
      product = Product.create(price_cents: 100, name: "name", id: 1, description: "hello", image: "www.no.go")
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
  
    it 'fails with no category' do
      product = Product.create(price: 100, quantity: 10, id: 1, description: "hello", image: "www.no.go")
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
    
  end
end
