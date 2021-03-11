require 'sinatra/base'
require './lib/peep'
require './database_connection_setup'
require 'time'
require './lib/user'

class ChitterApp < Sinatra::Base 
    enable :sessions
    
    get '/' do
        @user = User.find(session[:user_id])
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

    get '/users/new' do

        erb:'/users/new'
    end 

    post '/users' do
        User.create(email: params['email'], password: params['password'])
        session[:user_id] = user.id
        redirect '/'
    end

    run! if app_file == $0 
end 