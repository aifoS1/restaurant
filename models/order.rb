

class Order < ActiveRecord::Base

belongs_to :parties
belongs_to :foods



def self.seats
   range = (1..3)
   range.to_a
   
  end


end