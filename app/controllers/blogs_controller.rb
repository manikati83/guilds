class BlogsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_blog, only: %i[ show edit update destroy ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @blog = Blog.find(params[:id])
    @guild = @blog.guild
    @blog_tags = @guild.guild_blog_tags.all
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @guild = Guild.find(params[:guild_id])
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = current_user.blogs.build(blog_params)
    @guild = Guild.find(params[:guild_id])
    @blog.guild_id = @guild.id
    
    if params[:blog][:name] and params[:blog][:guild_blog_tag_id] == ""
      new_tag = @guild.guild_blog_tags.build(tag_params)
      new_tag.save
      @blog.guild_blog_tag_id = new_tag.id
    end
    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:guild_blog_tag_id, :title, :content)
    end
    
    def tag_params
      params.require(:blog).permit(:name)
    end
end
