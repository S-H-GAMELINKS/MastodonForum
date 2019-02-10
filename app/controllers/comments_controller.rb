class CommentsController < ApplicationController
    before_action :set_post

    def create
        @topic.comments.create! comments_params
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

         def comments_params
            params.required(:comment).permit(:content)
        end
end