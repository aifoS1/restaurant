class EmployeesController < ApplicationController

get '/' do
 @employees = Employee.all
 erb :'employees/index'
end

get '/new' do
 erb :'employees/new'
end

post '/' do 
    employee =Employee.create(params[:employee])
    redirect to "/#{employee.id}"
end

get '/:id' do |id|
  @employee = Employee.find(id)
  @party = Party.find_by(employee_id: id)
  erb :'employees/show'
end

get '/:id/edit' do |id|
 @employee = Employee.find(id)
 erb :'employees/edit'
end

patch '/:id' do |id|
    employee = Employee.find(id)
    employee.update(params[:employee])
    redirect to "/#{employee.id}"
end

delete '/:id' do |id|
    employee = Employee.find(id)
    employee.destroy
    redirect to "/"
end


end