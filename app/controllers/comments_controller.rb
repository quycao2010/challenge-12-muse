class CommentsController < ApplicationController
  before_action :check_login, only: [:edit, :update, :create, :destory]

  def new
      
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to  post_path(@post)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end
  
  private

  def comment_params
    params[:comment].permit(:content)
  end
  
  def check_login
    unless logged_in?
      redirect_to login_path, notice: "You have to login"
    end
  end
  
end
