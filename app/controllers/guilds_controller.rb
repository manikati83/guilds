class GuildsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_q
  
  def index
    @approval_guilds = current_user.approval_guilds.order(id: :desc).page(params[:page])
    @join_guilds = current_user.join_guilds.order(id: :desc).page(params[:page])
  end
  
  def show
    @guild = Guild.find(params[:id])
    @guild.image = 'top.jpg'
    @members = @guild.guild_members.all.order(id: :asc).page(params[:page]).per(25)
  end
  
  def new
    @guild = current_user.guilds.build
  end
  
  def create
    @guild = current_user.guilds.build(guild_params)
    if @guild.save
      @guild_member = current_user.guild_members.build(guild_id: @guild.id)
      @guild_member.save
      flash[:success] = 'ギルドを設立しました。'
      redirect_to @guild
    else
      flash.now[:danger] = 'ギルドを設立できませんでした。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  def tags
    @tag = Hashtag.find(params[:id])
    @guilds = @tag.guilds.order(id: :desc).page(params[:page]).per(25)
  end
  
  def search
    @guilds = @q.result.order(id: :desc).page(params[:page]).per(25)
    @guild_tags = Hashtag.find(GuildHashtagRelation.group(:hashtag_id).order('count(hashtag_id) desc').limit(10).pluck(:hashtag_id))
  end
  
  def blogs
    @guild = Guild.find(params[:id])
    @blogs = @guild.blogs.order(id: :desc).page(params[:page]).per(25)
    @blog_tags = @guild.guild_blog_tags.all
  end
  
  def members
    @guild = Guild.find(params[:id])
    @members = @guild.guild_members.all.order(id: :asc).page(params[:page]).per(25)
    @approvals = @guild.approvals.order(id: :desc).page(params[:page]).per(25)
  end
  
  def approval_members
    @guild = Guild.find(params[:id])
    @members = @guild.guild_members.all.order(id: :asc).page(params[:page]).per(25)
    @approvals = @guild.approvals.order(id: :desc).page(params[:page]).per(25)
  end
  
  
  
  
  
  private
  
  def set_q
    @q = Guild.ransack(params[:q])
  end
  
  def guild_params
    params.require(:guild).permit(:name, :content, :guild_type, :join_type, :limit_member, :hashbody, hashtag_ids: [])
  end
  

end
