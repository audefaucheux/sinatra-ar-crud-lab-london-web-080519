require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @title = params[:title]
    @content = params[:content]
    new_article = Article.create(title: @title, content: @content)
    redirect "/articles/#{Article.last.id}"
  end
  
  get '/articles' do    
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    article_id = params[:id]
    @article = Article.find(article_id)
    erb :show
  end

  get '/articles/:id/edit' do
    article_id = params[:id]
    @article = Article.find(article_id)
    erb :edit
  end

  patch '/articles/:id' do
    article_id = params[:id]
    title = params[:title]
    content = params[:content]
    @article = Article.find(article_id.to_i)
    @article.title = title
    @article.content = content
    @article.save
    erb :show
  end

  delete '/articles/:id' do
    article_id = params[:id]
    @article = Article.find(article_id.to_i)
    @article.destroy
  end

end
