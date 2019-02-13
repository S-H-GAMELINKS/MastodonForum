class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [:edit, :update]

    def edit
    end

    def create
        @topic.comments.create! comments_params
        @topic.comments.update(:user_id => current_user.id)
        redirect_to @topic
    end

    def update
        @comment.update(comments_params)
        redirect_to @topic
    end

    def destroy
        @topic.comments.destroy params[:id]
        redirect_to @topic
    end

     private
        def set_post
            @topic = Topic.find(params[:topic_id])
        end

        def set_comment
            @comment = Comment.find(params[:id])
        end

        def comments_params
            params.required(:comment).permit(:content)
        end
end