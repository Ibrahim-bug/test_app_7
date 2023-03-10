class ArticlesController < ApplicationController
  before_action  :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(articles_params)
    @article.user = User.first
    @article.save
    if @article.save
      flash[:notice] = "Article was created succussfully."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(articles_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title,:description)
  end

end
