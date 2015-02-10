Dir["models/*.rb"].each do |file|
    require_relative file
end

require 'date'
require 'active_support/inflector'
require 'sass'

class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :method_override
  enable :sessions
 set :default_currency_unit, "£"
 set :default_currency_precision, 2
 set :default_currency_separator, ' '


  get '/console' do
  Pry.start(binding)
  ""
  end

 configure do
   set :scss, {:style => :compressed, :debug_info => false}
 end

 get '/css/:name.css' do |name|
  content_type :css
  scss "../public/sass/#{name}".to_sym, :layout => false
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
    food = params[:food]
    item = Food.create(food)
    if item.valid?
      redirect to "/foods/#{item.id}"
    else
      @error_message = item.errors.messages
      erb :'foods/new'
    end
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
    @employees = Employee.all
    erb :'parties/new'
  end

  post '/parties' do
   party = params[:party]
   partyid = Party.create(party)

   redirect to "/parties/#{partyid.id}"
  end

  delete '/parties/:id' do |id|
   party = Party.find(id)
    party.destroy

   redirect to "/parties"
  end
  get '/parties/:id/edit' do
    @party = Party.find(params[:id])
    erb :'parties/edit'
  end

  patch '/parties/:id' do |id|
    party = Party.find(id)
    redirect to "/parties/#{party.id}"
  end

  get '/parties/:id' do |id|
    @party = Party.find(id)
    @foods = Food.all
     # Pry.start(binding)
     if @party.orders.any? 
   @currentTotal = @party.total 
   end

    erb :"parties/show"
  end


  ###ORDER

  # get '/orders/new' do
  #  @order = Order.all
  #  # @seats = Order.seats
  #  @parties = Party.all
  #  @foods = Food.all
  # erb :'orders/new'
  # end

  get '/orders' do
    @orders = Order.all
    @party = Party.all
    erb :'orders/index'
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

   post '/parties/:party_id/orders' do |party_id|

  params[:order].each do |seat_num, food_hash|
     
      order = Order.create(
        party_id: party_id,
        food_id: food_hash[:food_id],
        comped: food_hash[:comped],
        seat_number: seat_num
      )
      end

   redirect to "/parties/#{party_id}"
  end

  patch '/parties/:party_id/orders' do |party_id|
  
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
   redirect to "/parties/#{party_id}"
 end

 get '/parties/:id/receipt' do |id|
  @foods = Food.all
  @party= Party.find(id) 
 
   @currentTotal = @party.total
   # tipAmt = params[:party][:tip]

    @total =  @currentTotal + (@party.tip || 0.0 )
    erb :'parties/receipt'
 end

 patch '/parties/:id/receipt' do |id|
   @party= Party.find(id) 
   @party.update(params[:party])
   @currentTotal = @party.total

 
  redirect to "/parties/#{id}/receipt"
 end

##EMPLOYEES#########################################

get '/employees' do
 @employees = Employee.all
 erb :'employees/index'
end

get '/employees/new' do
 erb :'employees/new'
end

post '/employees' do 
    employee =Employee.create(params[:employee])
    redirect to "/employees/#{employee.id}"
end

get '/employees/:id' do |id|
  @employee = Employee.find(id)
  @party = Party.find_by(employee_id: id)
  erb :'employees/show'
end

get '/employees/:id/edit' do |id|
 @employee = Employee.find(id)
 erb :'employees/edit'
end

patch '/employees/:id' do |id|
    employee = Employee.find(id)
    employee.update(params[:employee])
    redirect to "/employees/#{employee.id}"
end

delete '/employees/:id' do |id|
    employee = Employee.find(id)
    employee.destroy
    redirect to "/employees"
end



end