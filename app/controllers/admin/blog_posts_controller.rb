# Admin blog posts controller
module Admin
  class BlogPostsController < BaseController
    include Pagy::Backend

    before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

    def index
      @pagy, @blog_posts = pagy(current_user.blog_posts.recent, limit: 20)
    end

    def show
    end

    def new
      @blog_post = BlogPost.new
    end

    def create
      @blog_post = current_user.blog_posts.build(blog_post_params)

      if @blog_post.save
        redirect_to admin_blog_post_path(@blog_post), notice: "Blog post created successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @blog_post.update(blog_post_params)
        redirect_to admin_blog_post_path(@blog_post), notice: "Blog post updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @blog_post.destroy
      redirect_to admin_blog_posts_path, notice: "Blog post deleted successfully"
    end

    private

    def set_blog_post
      @blog_post = current_user.blog_posts.friendly.find(params[:id])
    end

    def blog_post_params
      params.require(:blog_post).permit(:title, :content, :excerpt, :published, :cover_image)
    end
  end
end
