require 'byebug'
class PostsController < ApplicationController

  before_action :ensure_only_authors_can_edit_posts, only: [:edit, :update]

  def show
    @post = Post.includes(:author, :subs).find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params.merge(author_id: current_user.id))
    debugger
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to sub_url(post_params[:sub_id][0])
    end
  end

  def edit
    @sub = Sub.new
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :url, :content, :sub_id => [])
    end

    def ensure_only_authors_can_edit_posts
      @post = Post.find(params[:id])
      redirect_to post_url(@post) unless current_user.id == @post.author_id
    end
end
