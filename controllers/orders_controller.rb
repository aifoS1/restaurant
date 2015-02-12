class OrdersController < ApplicationController

 get '/' do
    @orders = Order.all
    @party = Party.all
    erb :'orders/index'
  end

  get '/:id/edit' do
    @order = Order.find(params[:id])
    erb :'orders/edit'
  end

  delete '/:id' do |id|
    order = Order.find(id)
    order.destroy

    redirect to "/"
  end

  patch '/:id' do |id|
    order = Order.find(id)
    order.update(params[:order])
    redirect to "/#{order.id}"
  end

  get '/:id' do |id|
   @order = Order.find(id)
   erb :"orders/show"
  end

end