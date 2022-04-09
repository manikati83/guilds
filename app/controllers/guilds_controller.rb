class GuildsController < ApplicationController
  
  def index
    @join_guilds = current_user.guilds.order(id: :desc).page(params[:page])
  end
  
  def show
    @guild = Guild.find(params[:id])
    @guild.image = 'carson.jpg'
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
  
  
  private
  
  def guild_params
    params.require(:guild).permit(:name, :content, :guild_type, :join_type, :limit_member, :hashbody, hashtag_ids: [])
  end
end
