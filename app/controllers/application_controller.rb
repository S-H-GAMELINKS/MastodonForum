class ApplicationController < ActionController::Base
    before_action :set_search

    def set_search
        @search = Topic.ransack(params[:q])
    end
end
