

class Party < ActiveRecord::Base
  
has_many :orders
has_many :foods, through: :orders
has_many :employees


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

def self.Total

   
   
end



end


# @opentable = (SELECT 
# * 
# FROM 
# parties
# Where 
# paid = false;
