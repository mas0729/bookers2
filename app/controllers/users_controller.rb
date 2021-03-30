class UsersController < ApplicationController

  before_action :authenticate_user!

  def index # /users

    # 画面表示用モデル
    @user = current_user
    @users = User.all

    # 新規登録用モデル
    @book = Book.new
  end

  def show # /users/:id
    # 画面表示用モデル
    @user = User.find(params[:id])
    @books = User.joins(:books).select('books.*, users.profile_image_id').where(id: @user.id)

    # 新規登録用モデル
    @book = Book.new
  end

  def edit # /users/:id/edit
    # 画面表示用モデル
    @user = User.find(params[:id])

    if @user.id != current_user.id then
      redirect_to user_path(current_user.id)
    end
  end

  def update #user 更新イベント

    @user = User.find(params[:id])

    # 更新(update)
    if @user.update(user_params) then

      # 更新メッセージを設定
      flash[:notice] = 'You have updated user successfully.'

      # 詳細画面(show)へ遷移
      redirect_to user_path(@user.id)

    # 更新が失敗した場合
    else
      # 編集画面(edit)を再描画
      render "users/edit"
    end
  end

  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
