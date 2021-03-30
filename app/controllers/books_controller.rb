class BooksController < ApplicationController

  before_action :authenticate_user!

  def index # /books

    # 画面表示用モデル
    @user = current_user
    @books = User.joins(:books).select('books.*, users.profile_image_id')

    # 新規登録用モデル
    @book = Book.new
  end


  def show # /books/:id
    # 画面表示用モデル
    @displaybook = Book.find(params[:id])
    @user = User.find(@displaybook.user_id)

    # 新規登録用モデル
    @book = Book.new
  end


  def edit # /books/:id/edit
    # 画面表示用モデル
    @book = Book.find(params[:id])

    if @book.user_id != current_user.id then
      redirect_to books_path
    end

  end

  def create #book 登録イベント

    # 画面の入力パラメータをモデルに設定
    @book = Book.new(book_params)

    # 登録(insert)
    if @book.save then

      # 登録メッセージを設定
      flash[:notice] = 'You have created book successfully.'

      # book/:id へ遷移
      redirect_to book_path(@book.id)

    # 更新が失敗した場合
    else

      # 再描画する際にActionを踏まないので必要
      # 画面表示用モデル
      @user = current_user
      @books = User.joins(:books).select('books.*, users.profile_image_id')

      # 初期画面(index)を再描画
      render "books/index"
    end
  end


  def update #book 更新イベント

    @book = Book.find(params[:id])

    # 更新(update)
    if @book.update(book_params) then

      # 更新メッセージを設定
      flash[:notice] = 'You have updated book successfully.'

      # 詳細画面(show)へ遷移
      redirect_to book_path(@book.id)

    # 更新が失敗した場合
    else
      # 編集画面(edit)を再描画
      render "books/edit"
    end
  end


  def destroy #book 削除イベント

    book = Book.find(params[:id])

    # 削除(delete)
    book.destroy

    # 初期画面(index)へ遷移
    redirect_to books_path
  end


  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body ,:user_id)
  end

end
