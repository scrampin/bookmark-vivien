require 'sinatra'
require_relative 'data_mapper_setup'


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
    link = Link.create(url: params[:new_link], title: params[:title])
    tag = Tag.first_or_create(name: params[:tags])
    link.tags << tag
    link.save
    redirect('/links')
  end


end
