class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #redirect_to book_path(@book.id)
    #redirect_back(fallback_location: root_path)いいね非同期通信　リダイレクト先がない場合はcreate.js.erbを探す
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)#ログインしているユーザーのいいねをユーザーのつながり
    favorite.destroy#消す
    #redirect_to book_path(@book.id)#showページのどの投稿に行くかを決めるために引数は必要
    #redirect_back(fallback_location: root_path)いいね非同期通信　リダイレクト先がない場合はdestroy.js.erbを探す
  end
end
