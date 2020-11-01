class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index 
        if params[:game_id] && @game = Game.find_by_id(params[:game_id])
            @comments = @game.comments 
        else
            @error = "That game doesn't exist" if params[:game_id]
            @comments = Comment.all 
        end
    end

    def new 
        if params[:game_id] && @game = Game.find_by_id(params[:game_id])
            @comment = @game.comments.build
        else
            @comment = Comment.new 
        end

    end


    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save 
            redirect_to comment_path(@comment)
        else
            render :new 
        end

    end

    def show 
        set_comment
    end

    def edit 
        set_comment
        redirect_to comments_path if @comment.user != current_user
    end

    def update
        set_comment
        redirect_to comments_path if @comment.user != current_user
        if @comment.update(comment_params)
          redirect_to comment_path(@comment)
        else
          render :edit
        end
      end

      def destroy 
        @comment = Comment.find_by_id(params[:id])
        @comment.destroy
        redirect_to game_comments_path(@comment.game)
      end



    private 

    def comment_params
        params.require(:comment).permit(:text, :game_id)
    end

    def set_comment 
        @comment = Comment.find_by(id: params[:id])
        redirect_to comments_path if !@comment
    end




end
