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
    tags = params[:tags].split(', ')
    tags.each { |tag| link.tags << Tag.first_or_create(name: tag) }
    link.save
    redirect('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links =  (tag ? tag.links : [])
    erb :'links/index'
  end

end
