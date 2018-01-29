require 'wikipedia'
class Api::V1::ArticlesController < ApplicationController
  def home
  end
  
  def index
    @articles = Article.where(user_id: current_user.id)
  end

  def create
    if current_user
      @article = Article.new(
                            user_id: current_user.id,
                            name: params[:name],
                            url: params[:url],
                            publisher: "Wikimedia Foundation, Inc",
                            medium: "Web",
                            content: params[:content],
                            image: params[:image],
                            summary: params[:sumamry]
                            )
      if @article.save
        flash[:success] = "Article Successfully Saved"
        redirect_to "/api/v1/articles/user_article/#{@article.id}"
      else
        flash[:warning] = "Error Saving Article, Please Try Again"
        redirect_to "/api/v1/articles/#{@name}"
      end
      # not a typo.
    else
      flash[:warning] = "You need to be logged in to save an article"
      redirect_to "/api/v1/login"
    end
  end
  
  def lookup
    @article = Article.wiki_find(params[:name])
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id])

    if article.destroy
      article.highlights.destroy_all
      redirect_to '/api/v1/articles'
    end
  end

  def contact
    
  end
end
