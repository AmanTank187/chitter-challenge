require 'sinatra/base'
require './lib/peep'
require './database_connection_setup'
require 'time'
require './lib/user'
require 'sinatra/flash'

class ChitterApp < Sinatra::Base 
    enable :sessions
    register Sinatra::Flash
    
    get '/' do
        @user = User.find(session[:user_id])
    if @user
        @peeps = Peep.all
        erb :"peeps/index"  
    else 
        redirect '/users/new'
      end
    end 

    get '/home' do
      @user = User.find(session[:user_id])
      @result = DatabaseConnection.query("SELECT * FROM peeps WHERE user_id = #{session[:user_id]};")
      erb:'/peeps/home'
    end 

    get '/peeps/new' do
        @user = User.find(session[:user_id])
        erb:'/peeps/new'
    end 

    post '/peeps' do
        Peep.create(message: params[:message],user_id: session[:user_id])
        redirect '/'
    end 

    get '/users/new' do
        @user = User.find(session[:user_id])
        if !@user
            erb :"users/new"
        else 
            redirect '/'
        end 
    end
      
    post '/users' do
        user = User.create(email: params[:email], password: params[:password])
        session[:user_id] = user.id
        redirect '/'
    end 

    get '/sessions/new' do
        @user = User.find(session[:user_id])
        if !@user
            erb :"sessions/new"
        else 
            redirect '/'
        end 
      end 

      post '/sessions' do
        user = User.authenticate(email: params[:email], password: params[:password])
        if user
          session[:user_id] = user.id
          redirect('/')
        else
          flash[:notice] = 'Please check your email or password.'
          redirect('/sessions/new')
        end
      end

      post '/sessions/destroy' do
        session.clear
        flash[:notice] = 'You have signed out.'
        redirect('/')
      end

    run! if app_file == $0 
end 