class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
  end

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs.order(id: :desc).limit(10)
    @guilds = @user.join_guilds.order(id: :desc).page(params[:page]).per(10)
    @quests = @user.quests.where(status: 0).order(id: :desc).page(params[:page]).per(10)
    if @user == current_user
      @notifications = current_user.notifications.order(id: :desc).limit(50)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def favorite_guilds
    @user = User.find(params[:id])
    @blogs = @user.blogs.order(id: :desc).limit(10)
    @guilds = @user.favorites.order(id: :desc).page(params[:page]).per(10)
    @quests = @user.quests.where(status: 0).order(id: :desc).page(params[:page]).per(10)
    if @user == current_user
      @notifications = current_user.notifications.order(id: :desc).limit(50)
    end
  end
  
  def approval_guilds
    @user = User.find(params[:id])
    @blogs = @user.blogs.order(id: :desc).limit(10)
    @guilds = @user.approval_guilds.order(id: :desc).page(params[:page]).per(10)
    @quests = @user.quests.where(status: 0).order(id: :desc).page(params[:page]).per(10)
    if @user == current_user
      @notifications = current_user.notifications.order(id: :desc).limit(50)
    end
  end
  
  def questing
    @user = User.find(params[:id])
    @blogs = @user.blogs.order(id: :desc).limit(10)
    @guilds = @user.join_guilds.order(id: :desc).page(params[:page]).per(10)
    @quests = @user.quests.where(status: 1).order(id: :desc).page(params[:page]).per(10)
    if @user == current_user
      @notifications = current_user.notifications.order(id: :desc).limit(50)
    end
  end
  
  def quested
    @user = User.find(params[:id])
    @blogs = @user.blogs.order(id: :desc).limit(10)
    @guilds = @user.join_guilds.order(id: :desc).page(params[:page]).per(10)
    @quests = @user.quests.where(status: 2).order(id: :desc).page(params[:page]).per(10)
    if @user == current_user
      @notifications = current_user.notifications.order(id: :desc).limit(50)
    end
  end
  
  def offer_questing
    @user = User.find(params[:id])
    @blogs = @user.blogs.order(id: :desc).limit(10)
    @guilds = @user.join_guilds.order(id: :desc).page(params[:page]).per(10)
    @quests = @user.join_quest.where(status: 1).order(id: :desc).page(params[:page]).per(10)
    if @user == current_user
      @notifications = current_user.notifications.order(id: :desc).limit(50)
    end
  end
  
  def offer_quested
    @user = User.find(params[:id])
    @blogs = @user.blogs.order(id: :desc).limit(10)
    @guilds = @user.join_guilds.order(id: :desc).page(params[:page]).per(10)
    @quests = @user.join_quest.where(status: 2).order(id: :desc).page(params[:page]).per(10)
    if @user == current_user
      @notifications = current_user.notifications.order(id: :desc).limit(50)
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
