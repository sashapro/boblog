class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @comment = current_user.comments.build(params[:comment])

    if @comment.save
      flash[:success] = "Successfully created comment."
      redirect_to :back
    else
       ######
      @user = Micropost.find(params[:comment][:micropost_id]).user
      @microposts = @user.microposts.paginate page: params[:page], per_page: 10
      render 'users/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end
end
