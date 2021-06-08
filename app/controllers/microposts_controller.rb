class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @user = current_user
    @micropost = current_user.microposts.build(micropost_params) if logged_in?
    @microposts = @user.microposts.paginate(page: params[:page])

    if @micropost.save
      flash[:success] = 'コメントを投稿しました!'
      redirect_to current_user
    else
      # @microposts = []
      render 'users/show'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'コメントが削除されました'
    redirect_to current_user
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
