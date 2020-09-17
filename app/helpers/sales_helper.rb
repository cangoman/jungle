module SalesHelper
  
  def active_sale?
    Sale.active.any?
  end

  def active_sale
    Sale.active.first
  end

  def sale_price price, percent_off
    price - (price * percent_off / 100)
  end




end
