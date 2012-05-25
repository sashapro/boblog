class MicropostsController < ApplicationController
  before_filter :signed_in_user
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

  private
  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end


end