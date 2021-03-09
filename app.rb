require 'sinatra/base'

class ChitterApp < Sinatra::Base 
    get '/' do
        "Welcome to Chitter"
    end 

    run! if app_file == $0 
end 