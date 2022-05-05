class RelationshipsController < ApplicationController
  def create#フォローする時
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy#ﾌｫﾛｰ外す時
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def followings#ﾌｫﾛｰ一覧
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers#ﾌｫﾛﾜｰ一覧
    user = User.find(params[:user_id])
    @users = user.followers
  end
end