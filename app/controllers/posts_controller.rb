class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    if current_user
      @topic = get_topic
      @post = @topic.posts.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to @topic
      else
        render :new
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @post = get_topic_post
  end

  def edit
    @post = get_topic_post
  end

  def update
    @post = get_topic_post
    if @post.update_attributes(post_params)
      redirect_to @topic
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def get_topic
    Topic.find(params[:topic_id])
  end

  def get_topic_post
    topic = Topic.find(params[:topic_id])
    topic.posts.find(params[:id])
  end
end
