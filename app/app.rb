ENV["RACK_ENV"] ||= "development"
require 'sinatra'
require_relative 'data_mapper_setup'
require 'sinatra/flash'



class BookmarkManager < Sinatra::Base
enable :sessions
set :session_secret, 'super secret'
register Sinatra::Flash


  get '/links' do
    @email = current_user.email if current_user
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end


  post '/links' do
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

  get '/user/new' do
    @user = User.new
    erb :'user/new'
  end

  post '/user' do
    @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if params[:password] == params[:password_confirmation]
      session[:id] = @user.id
      redirect('/links')
    else
      flash.now[:error] = "Your passwords did not match"
      erb :'/user/new'
    end
  end

  def current_user
    User.first(:id => session[:id])
  end

end
