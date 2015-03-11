class Amount
  
  # _charge: in pennies as per Stripe
  # _price:  for display purposes only
  
  def self.premium_membership_charge
    return 1500
  end
  
  def self.premium_membership_price
    return '$15.00'
  end
  
end