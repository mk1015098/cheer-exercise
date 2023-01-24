class User::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @post_tags = @post.tags
    @user = @post.user
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.page(params[:page])
    @tag_list=Tag.all
    @post = Post.new
    @user = current_user
  end

  def new
    @post = Post.new
    @user = current_user
    @posts = @user.posts
  end

  def create
    @post = Post.new(body: post_params[:body])
    @post.user_id = current_user.id
    @post.start_time = Date.today
    @tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(@tag_list)
      redirect_to user_posts_path(@post), notice:"Post success!"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = post_params[:name].split("，")
    post_atributes = post_params
    post_atributes.delete(:name)
    if @post.update(post_atributes)
        @old_relations = PostTag.where(post_id: @post.id)
        @old_relations.each do |relation|
          relation.delete
        end
        @post.save_tag(tag_list)
        redirect_to user_posts_path, notice:"Successful edit!"
    else render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path
  end

    def favorites
      @user = User.find(params[:id])
      favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
      @favorite_posts = Post.find(favorites)
    end

  private

  def post_params
    params.require(:post).permit(:body, :tag, :name)
  end
end
