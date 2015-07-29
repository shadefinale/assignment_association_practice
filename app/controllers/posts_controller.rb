class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(whitelist_post_params)
    if @post.save
      flash[:notice] = "Post #{@post.title} successfully created!"
      redirect_to @post
    else
      flash[:notice] = "Post failed to be created, try again."
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(whitelist_post_params)
      flash[:notice] = "Post #{@post.title} successfully edited!"
      redirect_to @post
    else
      flash[:notice] = "Post failed to be edited, try again."
      render :edit
    end
  end

  private

    def whitelist_post_params
      params.require(:post).permit(:title, :body, tag_ids: [])
    end
end