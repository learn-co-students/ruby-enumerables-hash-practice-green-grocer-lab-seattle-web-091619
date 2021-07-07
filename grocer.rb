def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |item|
    item.each do |key, value|
      count = 1
      if cart_hash.key? (key)
        count = cart_hash[key][:count] + 1
      else
        cart_hash[key] = value
      end
      cart_hash[key][:count] = count
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    if((cart.key? item_name) && (coupon[:num] <=  cart[item_name][:count]))
      if( !(cart.key?"#{item_name} W/COUPON"))
        cart["#{item_name} W/COUPON"] = {:count => 0}
      end
      cart["#{item_name} W/COUPON"][:count] = cart["#{item_name} W/COUPON"][:count] + coupon[:num]
      cart["#{item_name} W/COUPON"][:price] = ((coupon[:cost])/(coupon[:num])) 
      cart["#{item_name} W/COUPON"][:clearance] =  cart[item_name][:clearance]
      cart[item_name][:count] =  cart[item_name][:count] -  coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
   cart= cart.map do |item_name, value|
   if(value[:clearance])
     value[:price] = (value[:price]*0.8).round(2)
    end 
    [item_name , value]
  end.to_h
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total = cart.sum {|item , value| value[:price]*value[:count]  }
  if(total > 100.0)
    total = (total*0.9).round(2)
  end
  total
end

