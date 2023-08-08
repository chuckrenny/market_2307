require 'spec_helper'

RSpec.describe Vendor do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

  let(:vendor) {Vendor.new("Rocky Mountain Fresh")}

  describe "#initialize" do
    it 'exists as a Vendor class' do
      expect(vendor).to be_a(Vendor)
    end

    it 'can access Vendor attributes' do
      expect(vendor.name).to eq("Rocky Mountain Fresh")
      expect(vendor.inventory).to eq({})
    end
  end

  describe "#check_stock" do
    it 'can check the stock for an item and return the quantity' do
      expect(vendor.check_stock(item1)).to eq(0)
    end
  end

  describe "#stock" do
    it 'can stock the inventory for a quantity of the item' do
      vendor.stock(item1, 30)
      expect(vendor.check_stock(item1)).to eq(30)

      vendor.stock(item2, 12)
      total_inventory = {
        item1 => 30,
        item2 => 12
      }

      expect(vendor.inventory).to eq(total_inventory)
    end
  end
end