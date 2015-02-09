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

ActiveRecord::Base.connection.execute(<<-SQL
CREATE TABLE foods (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  cuisine_type varchar NOT NULL,
  price numeric NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  );

CREATE TABLE parties (
  id SERIAL PRIMARY KEY,
  table_name INT NOT NULL,
  guests INT NOT NULL,
  paid BOOLEAN default 'f',
  tip numeric,
  total numeric,
  employee_id INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,

  );

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  party_id INT NOT NULL,
  food_id INT,
  seat_number INT,
  comped BOOLEAN default 'f',
  created_at TIMESTAMP,
  updated_at TIMESTAMP,

  );

CREATE TABLE allergens (
  id SERIAL PRIMARY KEY,
  name TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP

  );

CREATE TABLE food_allergens (
  id SERIAL PRIMARY KEY,
  food_id INT,
  allergen_id INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
  );
 SQL)

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
  );
 SQL)

##FOODS
[

{
  name: "Cheeseburger",
  cuisine_type: "Sandwich",
  price: 6,

},
{
  name: "Grilled Cheese",
  cuisine_type: "Sandwich",
  price: 4,

},
{
  name: "Western Omelet",
  cuisine_type: "Breakfast",
  price: 6,

}


].each do |food|
  Food.create( food)
end

#Partys

[

{ 
  table_name: nil,
  guests: 2,
  paid: "FALSE",
    tip: nil,
    total: nil,
    employee_id: nil
},
{ table_name: nil,
  guests: 4,
  paid: "TRUE",
    tip: nil,
    total: nil,
    employee_id: nil
},
{ table_name: nil,
  guests: 3,
  paid: "FALSE",
     tip: nil,
    total: nil,
    employee_id: nil
}


].each do |party|
  Party.create( party)
end

  # ORDERS

  [

{
  party_id: nil,
  food_id: nil,
     seat_number: nil,
     comped: nil

},
{
  party_id: nil,
#  food_id: nil,
   seat_number: nil,
    comped: nil


},
{
  party_id: nil,
  food_id: nil,
    seat_number: nil,
     comped: nil

}

  ].each do |order|
    Order.create (order)
  end

## ALLERGENS

[
 {
   name: "Dairy"

 },
{
   name: "Gluten"

 },
 {
   name: "Soy"

 },
{
   name: "Eggs"

 },
 {
   name: "Nuts"

 }

].each do |allergen|
    Allergen.create (allergen)
  end


