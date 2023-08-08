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
  
  def item_count 
    # array of items with satisfactory quantity
    item_count = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        item_count[item] += quantity 
      end
    end
    item_count
  end

  def overstocked_items
    # array of item objects
    all_items = @vendors.flat_map { |vendor|
      vendor.inventory.keys
    }

    double_item = all_items.each_with_object(Hash.new(0)) do |item, hash|
      hash[item] += 1
    end.select { |item, count| count > 1 }.keys


    quantity_satisfactory = item_count.select {|item| item_count[item] >= 100}

    common_objects = double_item & quantity_satisfactory.keys
  end


  def total_inventory
    item_inventory = {}

    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if item_inventory[item]
          item_inventory[item][:quantity] += quantity
          item_inventory[item][:vendors] << vendor
        else
          item_inventory[item] = { 
            quantity: quantity,
            vendors: [vendor]
          }
        end
      end
    end
    item_inventory
  end
end