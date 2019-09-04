def consolidate_cart(cart)
  result = {}
  cart.map{|hashes| 
    hashes.map{|key,value|
    if result.has_key?(key)
      result[key][:count] += 1
         
    else
      result[key] = value
      result[key][:count] = 1 
    end
  }} 
  cart = result
  return cart
end

  
  
def apply_coupons(cart, coupons) 
  
  coupons.each do |coupon| 
    coupon.each do |k,v| 
      name = coupon[:item] 
    
      if cart[name] && cart[name][:count] >= coupon[:num] 
        if cart["#{name} W/COUPON"] 
          
          
          cart["#{name} W/COUPON"][:price] = (coupon[:cost] / ((cart[name][:count]) - ((cart[name][:count]) % (coupon[:num]))))
        else 

          cart["#{name} W/COUPON"] = {:price => (coupon[:cost] / ((cart[name][:count]) - ((cart[name][:count]) % (coupon[:num])))), 
          :clearance => cart[name][:clearance], :count => (cart[name][:count]) - ((cart[name][:count]) % (coupon[:num]))} 
        end 
  
      cart[name][:count] -= coupon[:num] 
    end 
  end 
end 
 return cart 
end

def apply_clearance(cart)
  cart.each do |k,v|
  if cart[k][:clearance]
    cart[k][:price] = (cart[k][:price] * 0.8).round(2)
    end
  end
  return cart
end





def checkout(cart, coupons)
  total = 0
  sum_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(sum_cart, coupons) 
  clearance_cart = apply_clearance(coupon_cart)
  
  clearance_cart.each do |fruit, value_hash|
    
    total += (value_hash[:price] * value_hash[:count])
  end 

  if total > 100 
    total = (total * 0.9) 
    end
return total
end
