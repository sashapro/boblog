class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    @comment = current_user.comments.build(params[:micropost])

    if @comment.save
      flash[:success] = "Successfully created comment."
      redirect_to current_user#redirect_to user_url(@comment.user_id)
    else
       ######
     # @microposts = current_user.microposts.paginate page: params[:page], per_page: 10
      #@user = current_user
      render 'users/show'
    end
  end

  def destroy
    # code here
  end

  private
  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_path if @comment.nil?
  end
end