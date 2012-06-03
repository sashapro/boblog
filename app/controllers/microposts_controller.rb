class MicropostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])

    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to current_user
    else
      @feed_items = [] ######
      @microposts = current_user.microposts.paginate page: params[:page], per_page: 10
      @user = current_user
      render 'users/show'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to current_user
  end

  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end

  private
  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end


end