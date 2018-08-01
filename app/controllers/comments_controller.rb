class CommentsController < ApplicationController
    before_action :set_comment, :only => [:edit, :update, :destroy]
    before_action :current_user_is_author?, :only => [:edit, :update, :destroy]

    def create
        @comment = Comment.new(comment_params)
        @comment.author_id = current_user.id
        #@comment.article_id = @article.id
        logger.debug("qqqq_comment:" + @comment.author_id.to_s)
        if @comment.save
            flash[:notice] = 'Comment has been created successfully.'
            
        else
            flash[:alert] = 'Comment hasn\'t been created successfully.'
        end
        redirect_to article_path(@comment.article_id)
    end

    def edit
        if !current_user_is_author?
            flash[:alert] = 'You can\'t edit this comment.'
            redirect_back(fallback_location: article_path(@comment.article_id))
        end
        @article = Article.find(@comment.article_id)
    end

    def update
        if !current_user_is_author?
            flash[:alert] = 'You can\'t edit this comment.'
            return redirect_to article_path(@comment.article_id)
        end

        if @comment.update(comment_params)
            flash[:notice] = 'Comment has been saved successfully.'
            redirect_to article_path(@comment.article_id)
        else
            flash[:alert] = 'Comment hasn\'t been saved successfully.'
            render :action => :edit
        end
    end

    def destroy
        if !current_user_is_author?
            flash[:alert] = 'You can\'t delete this comment.'
            return redirect_to article_path
        end

        @comment.destroy

        flash[:notice] = 'Comment has been deleted successfully.'
        redirect_to article_path(@comment.article_id)
    end

    private
        def comment_params
            params.require(:comment).permit(:content, :article_id, :author_id)
        end

        def current_user_is_author?
            @comment.author_id == current_user.id
        end

        def set_comment
            @comment = Comment.includes(:article, :user).find(params[:id])
        end
end
