require 'spec_helper'

RSpec.describe Item do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

  describe "#initialize" do
    it 'exists as an Item class' do
      expect(item1).to be_a(Item)
      expect(item2).to be_a(Item)
    end

    it 'can access attributes in the Item class' do
      expect(item2.name).to eq("Tomato")
      expect(item2.price).to eq(0.5)
    end
  end
end