require 'sinatra'

set :port, 8080
set :static, true
set :bind, '0.0.0.0'
set :public_folder, "static"
set :views, "views"

before do
    @defeat = {rock: :scissors, paper: :rock, scissors: :paper}
    @throws = @defeat.keys
end 

get '/' do
    erb :index
end

get '/throw/:type' do
    player_throw = params[:type].to_sym
    
    if !@throws.include?(player_throw)
        halt 403, "You must throw one of the follwoing: #{@throws}"
    end
    
    computer_throw = @throws.sample
    
    if player_throw == computer_throw
        erb :draw, :locals =>{:player_throw => player_throw, :computer_throw => computer_throw}
        # "You tied with the computer."
    elsif computer_throw == @defeat[player_throw]
        erb :win, :locals =>{:player_throw => player_throw, :computer_throw => computer_throw}
        # "Nicely done; #{player_throw} beats #{computer_throw}."
    else
        erb :lose, :locals =>{:player_throw => player_throw, :computer_throw => computer_throw}
        # "Ouch; #{computer_throw} beats #{player_throw}."
    end
end