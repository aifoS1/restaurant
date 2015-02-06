Dir["models/*.rb"].each do |file|
    require_relative file
end

require 'active_support/inflector'

class Restaurant < Sinatra::Base
    register Sinatra::ActiveRecordExtension
   enable :method_override

get '/console' do
Pry.start(binding)
""
end

get '/' do
  erb :index
end

get '/foods' do
  @menu = Food.all

 erb :"foods/index"
end

get '/foods/new' do
  
  erb :'foods/new'
end

post '/foods' do
# Pry.start(binding)
 food = params[:food]
 item = Food.create(food)
 redirect to "/foods/#{item.id}"
end

get '/foods/:id/edit' do
  @food = Food.find(params[:id])
  erb :'foods/edit'
end

delete '/foods/:id' do |id|
  food = Food.find(id)
  food.destroy

  redirect to "/foods"
end

patch '/foods/:id' do |id|
  food = Food.find(id)
  food.update(params[:food])
  redirect to "/foods/#{food.id}"
end

get '/foods/:id' do |id|
 @food = Food.find(id)

 erb :"foods/show"
end

##PARTIES

get '/parties' do

@parties= Party.all
  erb :'/parties/index'
end

get '/parties/new' do
  @available = Party.opentables
  
  erb :'parties/new'
end

post '/parties' do
# Pry.start(binding)

 party = params[:party]
 partyid = Party.create(party)
 redirect to "/parties/#{partyid.id}"
end

get '/parties/:id/edit' do
  @party = Party.find(params[:id])
  erb :'parties/edit'
end

patch '/parties/:id' do |id|
   party= Party.find(id)
  party.update(params[:parties])
  redirect to "/parties/#{party.id}"
end

get '/parties/:id' do |id|
 @foods = Food.all
 @party = Party.find(id)
 a = Order.find(id)
 a.update(receipt_id: id)

 @seats = []
 @party.guests.times do |x|
  @seats.push(x)
  end
      index=1
     @seats.times do

    a.update(seat_number: index)

    index += 1
    end


   erb :"parties/show"
end




###ORDERS

get '/orders' do


erb :'orders/index'
end

get '/orders/new' do
 @order = Order.all
 # @seats = Order.seats
 @parties = Party.all
 @foods = Food.all
erb :'orders/new'
end

post '/orders' do
# Pry.start(binding)
 order = params[:order]
 orderid = Order.create(order)
 redirect to "/orders/#{orderid.id}"
end

get '/orders/:id/edit' do
  @order = Order.find(params[:id])
  erb :'orders/edit'
end

delete '/orders/:id' do |id|
  order = Order.find(id)
  order.destroy

  redirect to "/orders"
end

patch '/orders/:id' do |id|
  order = Order.find(id)
  order.update(params[:order])
  redirect to "/orders/#{order.id}"
end

get '/orders/:id' do |id|

 @order = Order.find(id)

 erb :"orders/show"
  end






end