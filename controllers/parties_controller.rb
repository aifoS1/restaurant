class PartiesController < ApplicationController

get '/' do
    @parties= Party.all
    erb :'/parties/index'
end

 get '/new' do
    @available = Party.opentables 
    @employees = Employee.all
    erb :'parties/new'
 end

  post '/' do
   party = params[:party]
   partyid = Party.create(party)

   redirect to "/#{partyid.id}"
  end

  delete '/:id' do |id|
   party = Party.find(id)
    party.destroy

   redirect to "/"
  end
  get '/:id/edit' do
    @party = Party.find(params[:id])
    erb :'parties/edit'
  end

  patch '/:id' do |id|
    party = Party.find(id)
    redirect to "/#{party.id}"
  end

  get '/:id' do |id|
    @party = Party.find(id)
    @foods = Food.all
     # Pry.start(binding)
     if @party.orders.any? 
   @currentTotal = @party.total 
   end

    erb :"parties/show"
  end

  post '/:party_id/orders' do |party_id|

  params[:order].each do |seat_num, food_hash|
     
      order = Order.create(
        party_id: party_id,
        food_id: food_hash[:food_id],
        comped: food_hash[:comped],
        seat_number: seat_num
      )
      end

   redirect to "/#{party_id}"
  end

  patch '/:party_id/orders' do |party_id|
  
    @party = Party.find(party_id)
    params[:order].each do |seat_number, food_hash|

      order = Order.find_by(
        seat_number: seat_number, party_id: @party.id
      )
      order.update(
        food_id: food_hash[:food_id],
        comped: food_hash[:comped]

      )
    end
   redirect to "/#{party_id}"
 end

 get '/:id/receipt' do |id|
   @foods = Food.all
   @party= Party.find(id) 
 
   @currentTotal = @party.total
   # tipAmt = params[:party][:tip]
    @total =  @currentTotal + (@party.tip || 0.0 )
    erb :'parties/receipt'
 end

 patch '/:id/receipt' do |id|
   @party= Party.find(id) 
   @party.update(params[:party])
   @currentTotal = @party.total

 
  redirect to "/#{id}/receipt"
 end

end