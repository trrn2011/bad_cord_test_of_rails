class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  def index
    articles = Article.open.includes(:category)
    @articles = Article.search_articles(articles, params)
    @categories = Category.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path, flash: { success: 'articleが作成されました' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to root_path, flash: { success: 'articleが更新されました' }
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path, flash: { success: 'articleが削除されました' }
    else
      redirect_to root_path, flash: { error: 'articleの削除に失敗しました' }
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :category_id,
      :user_id,
    )
  end

end