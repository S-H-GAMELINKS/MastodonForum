class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit]

  # kaminari per
  PER = 10

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.page(params[:page]).per(PER)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @comments = Comment.where(:topic_id => params[:id]).page(params[:page]).per(PER)
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @categories = Category.all
  end

  # GET /topics/1/edit
  def edit
    @categories = Category.all
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def check_user
      if !user_signed_in?
        redirect_to :root
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :content, :category)
    end
end
