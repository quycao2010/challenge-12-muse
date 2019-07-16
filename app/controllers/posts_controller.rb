class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :destory]
  before_action :check_login, only: [:edit, :update, :destory, :new, :create]

  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
  

  def new
    @post = current_user.posts.build
  end

  def upload_img
    client_id = '2269f5146334924'
    client = Imgur::Client.new(client_id)
    img_path = post_params[:image]
    image = Imgur::LocalImage.new(img_path, title: 'Awesome photo')
    @uploaded = client.upload(image)
  end
  
  
  def create
    @user = current_user
    data = post_params
    data[:image] = upload_img.link
    @post = @user.posts.create(data)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end 
  end

  def edit
  end
  
  def update
    data = post_params
    data[:image] = upload_img.link
    if @post.update(data)
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
    params[:post].permit(:title, :description, :link, :image)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end

  def check_login
    unless logged_in?
      redirect_to login_path
    end
  end
  
end
