class HomeController < ApplicationController
  def index
 @posts = Post.order("created_at DESC").paginate(page: params[:page], per_page: 5)
    # @posts = Post.all.order("created_at DESC")
  end
end
