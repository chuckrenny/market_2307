require 'spec_helper'

RSpec.describe Market do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  let(:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let(:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let(:vendor3) {Vendor.new("Palisade Peach Shack")}

  let(:market) {Market.new("South Pearl Street Farmers Market")}

  describe "#initialize" do
    it 'exists as an Market class' do
      expect(market).to be_a(Market)
    end

    it 'can access Market attributes' do
      expect(market.name).to eq("South Pearl Street Farmers Market")
      expect(market.vendors).to eq([])
    end
  end

  describe "#add_vendor" do
    it 'can add vendors to the vendor list' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      
      expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    end
  end

  describe "#vendor_names" do
    it 'can return an array of all Vendor names' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      
      expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe "#vendors_that_sell" do
    it 'can check for all vendors that sell a given item' do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end
  end

  describe "#potential_revenue" do
    it 'can sum all of an items\' price by quantity' do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(vendor1.potential_revenue).to eq(29.75)
      expect(vendor2.potential_revenue).to eq(345.00)
      expect(vendor3.potential_revenue).to eq(48.75)
    end
  end

  describe "#sorted_item_list" do
    it 'can find the names of all items the Vendors have in stock' do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor1.stock(item3, 25)
      vendor1.stock(item4, 50)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.sorted_item_list).to eq(['Banana Nice Cream', 'Peach', 'Peach-Raspberry Nice Cream', 'Tomato'])
    end
  end

  describe "#overstocked_items" do
    it 'can find array of items that are overstocked' do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor1.stock(item3, 25)
      vendor1.stock(item4, 50)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      # An array of Item objects that are overstocked. 
      # An item is overstocked if it is sold by more than 1 vendor 
      # AND the total quantity is greater than 50.

      expect(market.overstocked_items).to eq([item1,item4])
    end
  end

  describe "total_inventory" do
    it 'can find the quantity of all items sold at the market' do
      # Reports the quantities of all items sold at the market. 
      # Specifically, it should return a hash with items as keys and 
      # hashes as values - this sub-hash should have two key/value pairs: 
      # quantity pointing to total inventory for that item and vendors 
      # pointing to an array of the vendors that sell that item.
      # {
      #   items => {
      #     quantity => total_inventory for that item,
      #     vendors => array of vendors that sell taht item
      #   }
      # }

      
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor1.stock(item3, 25)
      vendor1.stock(item4, 50)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      item_inventory = {
        item1 => {
          quantity: 100,
          vendors: [vendor1, vendor3]
        },
        item2 => {
          quantity: 7,
          vendors: [vendor1]
        },
        item3 => {
          quantity: 50,
          vendors: [vendor1, vendor2]
        },
        item4 => {
          quantity: 100,
          vendors: [vendor1, vendor2]
        }
      }

      expect(market.total_inventory).to eq(item_inventory)
    end
  end
end