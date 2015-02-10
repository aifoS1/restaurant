
class Party < ActiveRecord::Base
  
has_many :orders, dependent: :destroy
has_many :foods, through: :orders
has_many :employees
accepts_nested_attributes_for :foods


def self.opentables
   range = (1..8)
   table = range.to_a
   parties = Party.all
   not_paid = parties.where(paid: 'f')
   unavailble=  not_paid.map do |table|
            table.table_name
           end
   return table - unavailble
  end

def total 
    paidItems= orders.where(comped: false)
    @currentTotal =0
    paidItems.each do |order|
       @currentTotal += order.food.price if order.food
    end
     @currentTotal 
 end
end