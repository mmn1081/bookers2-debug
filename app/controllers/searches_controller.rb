class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]#検索モデル
    @content = params[:content]#検索内容
    @search = params[:search]#検索の仕方の選択
      if @range == "User"
         @users = User.looks(@search, @content)#検索方法→params[:search] 検索ワード→params[:word]
      else
         @books = Book.looks(@search, @content)
      end
  end
end