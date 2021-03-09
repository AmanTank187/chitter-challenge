require 'sinatra/base'
require './lib/peep'
require './database_connection_setup'

class ChitterApp < Sinatra::Base 
    enable :sessions
    
    get '/' do
          @peeps = Peep.all
          erb :"peeps/index" 
          
      end

    get '/peeps/new' do

        erb:'/peeps/new'
    end 

    post '/peeps' do
        Peep.create(message: params[:message])
        redirect '/'
    end 

    run! if app_file == $0 
end 