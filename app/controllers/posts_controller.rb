class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index,:show]


  # GET /posts
  # GET /posts.json
  def index
    user = current_user
    @posts = user.posts
    # @posts = Post.all.order('created_at desc')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    if session[:user_id] == nil
     redirect_to home_path, notice: 'You must log in to access this page.'
   end
  end

  # GET /posts/1/edit
  def edit
    unless @post.user == current_user
      redirect_to home_path, notice: "This post doesn't belong to you!"
    end

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    # this adds in the current user id for the post
    @post.user = current_user
    respond_to do |format|
      if @post.save
        # format.html { redirect_to @post, notice: 'Post was successfully created.' }
        # format.json { render :show, status: :created, location: @post }
        # format.html { redirect_to user_posts_path(@post.user, @post), notice: 'successfully created' }

        format.html { redirect_to user_post_path(session[:user_id], Post.last), notice: 'successfully created' }

        format.json { render :show, status: :created, location: @post}

      else
        format.html { render :new }
        format.json { render json: @post, status: :unprocessable_entity }
      end
    end



  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.user != current_user
    format.html { render "root", notice: "This post doesn't belong to you!" }
  end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_path(@post.user, @post), notice: 'successfully updated' }
        # format.html { redirect_to edit_user_posts_path, notice: 'Post was successfully updated.' }

        format.json { render :show, status: :ok, location: user_post_path }
        #  format.json { render :show, status: :ok, location: edit_user_posts_path }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        #  format.json { render json: edit_user_posts_path.errors, status: :unprocessable_entity }

      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      # format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.html { redirect_to user_posts_path	, notice: 'Post was successfully destroyed.' }

      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    #  @post = Post.find(params[:user_id])
    @post = Post.find(params[:id])
    # @post = Post.find(session[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params

    params.require(:post).permit(:title, :body)

  end

end
