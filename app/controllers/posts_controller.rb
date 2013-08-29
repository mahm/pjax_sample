class PostsController < ApplicationController
  before_filter :load_posts
  before_filter :load_post, only: %w(show edit update destroy)

  def index
    if @posts.blank?
      redirect_to [:new, :post]
    else
      render
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to [:posts] }
    end
  end

  private
  def load_posts
    @posts = Post.order('created_at DESC')
  end

  def load_post
    @post = Post.find(params[:id])
  end
end