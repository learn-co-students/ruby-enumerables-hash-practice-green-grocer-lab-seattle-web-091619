def consolidate_cart(cart)
  new_cart = []
  #new_sans_count = new_cart.each {|item| item.reject {|k,v| k == [:count]}}
  
  cart.map {
    |item|
    p item
    
    
    if new_cart.include?(item)
      #item[:count] += 1
      
      p "true"
    else
      item[:count] = 1
      new_cart.push(item)
      p "false"
    end
    
  }
  
  p new_cart
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

consolidate_cart([
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"KALE" => {:price => 3.00, :clearance => false}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"KALE" => {:price => 3.00, :clearance => false}},
  ])
