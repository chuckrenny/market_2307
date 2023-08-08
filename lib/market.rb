class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor if vendor.inventory[item]
    end
  end

  def sorted_item_list
    @vendors.flat_map { |vendor|
      vendor.inventory.keys
           }.map { |item| item.name }.uniq.sort
  end
  # def total_inventory
end