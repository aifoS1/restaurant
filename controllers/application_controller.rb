class ApplicationController < Sinatra::Base
  # helpers ApplicationHelper
  register Sinatra::ActiveRecordExtension
 enable :method_override
 enable :sessions
 set :default_currency_unit, "£"
 set :default_currency_precision, 2
 set :default_currency_separator, ' '

  set :root, Proc.new { File.expand_path('../..', __FILE__) }
  set :views, Proc.new { File.join(root, 'views') }
  set :public_folder, Proc.new { File.join(root, 'public') }


end