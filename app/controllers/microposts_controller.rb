class MicropostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @micropost = current_user.microposts.build(params[:micropost])

    if @micropost.save
      flash[:success] = t("microposts")
      redirect_to :back
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
end
