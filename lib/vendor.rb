class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if !@inventory[item]
      0
    else
      @inventory[item]
    end
  end

  def stock(item, quantity)
    @inventory[item] = quantity
  end

  def potential_revenue 
    @inventory.sum { |item, quantity| item.price * quantity }
  end  
end