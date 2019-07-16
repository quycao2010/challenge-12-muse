class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :destory]

  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
  

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end 
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit
    end 
  end
  
  def destroy
    @post.destroy
    redirect_to root_path
  end
  
  private

  def post_params
    params[:post].permit(:title, :description, :link)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
end
