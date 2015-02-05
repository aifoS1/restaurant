require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
   adapter: :postgresql,
   database: "restaurant",
   host: "localhost", port: 5432

  )

##FOODS
# [

# {
#   name: "Cheeseburger",
#   cuisine_type: "Sandwich",
#   price: 6,
#   allergens: "dairy"

# },
# {
#   name: "Grilled Cheese",
#   cuisine_type: "Sandwich",
#   price: 4,
#   allergens: "dairy"

# },
# {
#   name: "Western Omelet",
#   cuisine_type: "Breakfast",
#   price: 6,
#   allergens: "eggs, dairy"

# }


# ].each do |food|
#   Food.create( food)
# end

##Partys

[

{ 
  table_id: nil,
  guests: 2,
  paid: "FALSE",
},
{ table_id: nil,
  guests: 4,
  paid: "TRUE",
},
{ table_id: nil,
  guests: 3,
  paid: "FALSE",
}


].each do |party|
  Party.create( party)
end

  ## ORDERS

#   [

# {
#   party_id: nil,
#   food_id: nil

# },
# {
#   party_id: nil,
#   food_id: nil

# },
# {
#   party_id: nil,
#   food_id: nil

# }

#   ].each do |order|
#     Order.create (order)
#   end






