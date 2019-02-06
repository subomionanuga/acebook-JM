require 'pry'

class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_post, only: [:edit, :show, :update, :destroy]
  before_action :all_posts, only: [:index, :destroy]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
    redirect_to @post, notice: "Yessss, it was posted!"
    else
    render "new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "update successful"
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.id == @post.user_id
      @post.destroy
      redirect_to posts_path
    else
      render 'index', notice: "You cannot delete this post"
    end
  end

  def show
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end

  def all_posts
    @posts = Post.all
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
