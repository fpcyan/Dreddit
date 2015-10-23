class PostsController < ApplicationController

  before_action :ensure_only_authors_can_edit_posts, only: [:edit, :update]

  def show
    @post = Post.includes(:author).find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    render :new
  end

  def create
    @sub = Sub.find_by(title: params[:sub][:title])
    @post = Post.new(post_params.merge(author_id: current_user.id, sub_id: @sub.id))

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.new
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
      params.require(:post).permit(:title, :url, :content)
    end

    def ensure_only_authors_can_edit_posts
      @post = Post.find(params[:id])
      redirect_to post_url(@post) unless current_user.id == @post.author_id
    end
end
