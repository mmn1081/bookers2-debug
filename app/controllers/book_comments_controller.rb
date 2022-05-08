class BookCommentsController < ApplicationController#コメント機能部分
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
    #redirect_to book_path(@book.id)#showページのどの投稿に行くかを決めるために引数は必要 非同期通信のため
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.find_by(book_id: @book.id)
    @comment.destroy
    #redirect_to book_path(params[:book_id])#非同期通信のため
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end