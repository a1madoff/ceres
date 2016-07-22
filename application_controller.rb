require 'bundler'
Bundler.require
require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index
  end
  
  # get '/results' do
  #   erb :results
  # end
  
  post '/results' do
    @answer = format_request_and_send_api_call(params[:date])
    
    erb :results
  end

end
