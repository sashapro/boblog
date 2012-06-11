class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.paginate page: params[:page], order: 'created_at desc',
      per_page: 10
  end

  def show
    @user = User.find(params[:id])
      @microposts = @user.microposts.paginate page: params[:page], per_page: 10
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @title = t("shared._stats.following")
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = t("shared._stats.followers")
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
