class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :require_user, except: [:index]

  # GET /posts
  def index
    if current_user
      @posts = current_user.chirps

      render json: @posts, scope: current_user, scope_name: :current_user
    else
      @posts = Post.all

      render json: @posts, each_serializer: UnauthedPostsSerializer
    end
  end

  # GET /posts/1
  def show
    render json: @post, scope: current_user, scope_name: :current_user
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post, scope: current_user, scope_name: :current_user
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.permit(:body)
    end
end
