class Api::V1::HighlightsController < ApplicationController
  def index
    @highlights = current_user.highlights
  end

  def create
    @highlight = Highlight.new(
                              selection: params[:selection],
                              user_id: params[:user_id],
                              article_id: params[:article_id]
                              )
    if @highlight.save
      redirect_to "/api/v1/articles/user_article/#{@highlight.article_id}"
    else
      redirect_to "/api/v1/home"
    end
  end

  def destroy
    highlight = Highlight.find(params[:id])
    highlight.destroy
    redirect_to "/api/v1/articles/user_article/#{highlight.article_id}"
  end

  def api_find_create
   article = Article.find_or_create_by!(article_title: params[:article_title], user_id: 1)
   Highlight.create(
                  selection: params[:selection],
                  article_id: article.id,
                  user_id: 1
                  )
  end
end
