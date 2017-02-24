require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do

    it 'requires a title and a price' do
      p = Product.new
      p.valid?
      expect(p.errors).to have_key(:title) and have_key(:price)
    end

    it 'requires a unique title' do
      Product.create({title:'abc', price: 2})
      p = Product.new({title:'abc'})
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it 'requires sale_price set to price if not present' do
      p = Product.create({title:'abc', price: 2})
      expect(p.price).to eq(p.sale_price)
    end

    it 'requires sale_price to be less than or equal to price' do
      p = Product.new({title: 'abc', price: 2, sale_price: 3})
      p.valid?
      expect(p.errors).to have_key(:sale_price)
    end

    it 'requires method on_sale?' do
      p = Product.new({title: 'abc', price: 2, sale_price: 1})
      x = Product.new({title: 'abcd', price: 2, sale_price: 2})
      y = Product.new({title: 'abcde', price: 2, sale_price: 3})
      expect(p.on_sale?).to eq(true)
      expect(x.on_sale?).to eq(false)
      expect(y.on_sale?).to eq(false)
    end
  end
end
