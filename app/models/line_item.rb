class LineItem < ActiveRecord::Base
  belongs_to :listing
  belongs_to :cart

  def total_price
		listing.price * quantity
	end

end

