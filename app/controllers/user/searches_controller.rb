class User::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:tag_search]
      @posts = Post.tag_looks(params[:word])
    else
      @posts = Post.post_looks(params[:word])
    end
    render "user/searches/search_result"
  end
end
