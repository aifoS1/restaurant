class FoodsController < ApplicationController

  get '/' do
    @menu = Food.all

   erb :"foods/index"
  end

  get '/new' do
    
    erb :'foods/new'
  end

post '/' do
    food = params[:food]
    item = Food.create(food)
    if item.valid?
      redirect to "/#{item.id}"
    else
      @error_message = item.errors.messages
      erb :'foods/new'
    end
  end

  get '/:id/edit' do
    @food = Food.find(params[:id])
    erb :'foods/edit'
  end

  delete '/:id' do |id|
    food = Food.find(id)
    food.destroy

    redirect to "/"
  end

  patch '/:id' do |id|
    food = Food.find(id)
    food.update(params[:food])
    redirect to "/#{food.id}"
  end

  get '/:id' do |id|
   @food = Food.find(id)

   erb :"foods/show"
  end


end