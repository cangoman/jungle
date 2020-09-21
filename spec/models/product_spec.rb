require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it "creates a product when all fields are valid" do
        @category = Category.new name: 'test_category'
        @category.save
        @product = Product.new name: 'test_name', price: 500, quantity: 1, category: @category 
        @product.save
        
        expect(@product).to be_present
    end

    it "should not create a product without a valid name" do
      @category = Category.new(name: 'test_category')
      @category.save
      @product = Product.new(name: nil, price: 500, quantity: 1, category: @category)
      @product.save
      
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not create a product without price" do
      @category = Category.new(name: 'test_category')
      @category.save
      @product = Product.new(name: 'test_name', price: nil, quantity: 1, category: @category)
      @product.save
      
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not create a product without a quantity" do
      @category = Category.new(name: 'test_category')
      @category.save
      @product = Product.new(name: 'test_name', price: 200, quantity: nil, category: @category)
      @product.save
      
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not create a product without a category" do
      @product = Product.new(name: "test_name", price: 500, quantity: 1, category: nil)
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end



  
  end
end
