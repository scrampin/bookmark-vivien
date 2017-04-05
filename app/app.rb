require 'sinatra'
require './app/models/link'


class BookmarkManager < Sinatra::Base
ENV["RACK_ENV"] ||= "development"


  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end


  post '/add_link' do
    Link.create(url: params[:new_link], title: params[:title])
    redirect('/links')
  end


end
