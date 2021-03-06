class ArticlesController < ApplicationController
    before_action :set_article, :only => [:edit, :update, :show, :destroy]
    before_action :current_user_is_author?, :only => [:edit, :update, :destroy]

    def index
        @articles = Article.includes(:user).page(params[:page]).per(5).order(updated_at: :desc)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.author_id = current_user.id
        if @article.save
            flash[:notice] = 'Article has been created successfully.'
            redirect_to :action => :index
        else
            flash[:alert] = 'Article hasn\'t been created successfully.'
            render :action => :new
        end
    end

    def edit
        if  !current_user_is_author?
            flash[:alert] = 'You can\'t edit this article.'
            render :action => :show
        end
    end

    def update
        if !current_user_is_author?
            flash[:alert] = 'You can\'t edit this article.'
            return render :action => :show
        end
        
        if @article.update(article_params)
            flash[:notice] = 'Article has been saved successfully.'
            redirect_to :action => :show, :id => @article
        else
            flash[:alert] = 'Article hasn\'t been saved successfully.'
            render :action => :edit
        end
    end

    def show
        @comment = Comment.new
    end

    def destroy
        if !current_user_is_author?
            flash[:alert] = 'You can\'t delete this article.'
            return render :action => :edit
        end
        @article.destroy

        flash[:notice] = 'Article has been deleted successfully.'
        redirect_to :action => :index
    end

    private
        def article_params
            params.require(:article).permit(:title, :content, :author_id)
        end

        def set_article
            @article = Article.includes(:comments, :user).find(params[:id])
        end

        def current_user_is_author?
            current_user.id == @article.author_id
        end
end
