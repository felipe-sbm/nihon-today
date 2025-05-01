class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @news = NewsApiService.fetch_news("Japan")["articles"]
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Notícia criada com sucesso!"
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: "Notícia atualizada com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: "Notícia excluída com sucesso!"
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
