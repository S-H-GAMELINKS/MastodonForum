class SearchController < ApplicationController

    PER = 10

    def index
        @search = Topic.ransack(params[:q])
        @topics = @search.result.page(params[:page]).per(PER)
    end
end