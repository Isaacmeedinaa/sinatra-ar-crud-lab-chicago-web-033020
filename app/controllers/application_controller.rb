
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles/new'
  end

  # show article creation form
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  # show all article
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # create a new article
  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  end

  # show specific article by id
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  # show article update form for specific article with id
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # update an article with specific id
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    redirect to "/articles/#{ @article.id }"
  end

  # delete an article with specific id
  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
    redirect to '/articles'
  end
end
