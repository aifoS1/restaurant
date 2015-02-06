

class Order < ActiveRecord::Base

belongs_to :party

belongs_to :food



def self.createOrder
  @order.each do |key, value|
      Order.create (value)

     end


  end

def self.updateReceipt(id, order)

 # @a = Order.find(id)
 order.update(receipt_id: id)
 # @orderid.save
end


def self.updateSeatNum
  seats = []

 @party.guests.times do |x|
    seats.push(x)
  end
    index=1
   seats.times do

    @a.update(seat_number: index)

    index += 1
    end
end

end